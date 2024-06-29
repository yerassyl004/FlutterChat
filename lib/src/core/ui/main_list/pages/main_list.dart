import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../../bloc/chat_service/chat_service.dart';
import '../../../models/user/user.dart';
import '../../../models/chat_model/chat.dart';
import '../../../models/message/message.dart';
import '../widgets/header_widget.dart';
import '../widgets/list_item.dart';

class MainList extends StatefulWidget {
  const MainList({super.key});

  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> with RouteAware {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final ChatService _chatService = ChatService();
  final List<User> users = [
    User(id: '1', name: 'Виктор Власов', chatId: '1-2'),
    User(id: '2', name: 'Саша Алексеев', chatId: '1-2'),
    User(id: '3', name: 'Петр Жаринов', chatId: '3-4'),
    User(id: '4', name: 'Алина Жукова', chatId: '3-4'),
  ];
  bool _isLoading = true;
  late List<Chat> chats;

  @override
  void initState() {
    super.initState();
    _initializeChats();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteObserver<ModalRoute>().subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    RouteObserver<ModalRoute>().unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _initializeChats();
  }

  Future<void> _initializeChats() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Chat> loadedChats = [];
      for (final user in users) {
        String chatId = _chatService.generateChatId(user.id, _receiver(user.id));
        String? chatJson = await storage.read(key: chatId);
        if (chatJson != null) {
          Map<String, dynamic> chatMap = jsonDecode(chatJson);
          loadedChats.add(Chat.fromJson(chatMap));
        } else {
          Chat newChat = Chat(id: chatId, messages: []);
          await _chatService.saveChat(newChat);
          loadedChats.add(newChat);
        }
      }

      setState(() {
        chats = loadedChats;
        _isLoading = false;
      });
    } catch (e) {
      print('Error initializing chats: $e');
    }
  }

  String _receiver(String userId) {
    switch (userId) {
      case '1':
        return '2';
      case '2':
        return '1';
      case '3':
        return '4';
      case '4':
        return '3';
      default:
        return '';
    }
  }

  Future<void> _refreshChats() async {
    await _initializeChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _refreshChats,
        child: CustomScrollView(
          slivers: <Widget>[
            HeaderWidget(
              title: 'Чаты',
              onSearchChanged: (String value) {},
              onSearchSubmitted: (String value) {},
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return FutureBuilder<Message?>(
                    future: _chatService.getLastMessage(users[index].chatId),
                    builder: (context, snapshot) {
                      return ListItem(
                        user: users[index],
                        receiver: users[_receiverIndex(index)],
                        lastMessage: snapshot.data,
                      );
                    },
                  );
                },
                childCount: users.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _receiverIndex(int index) {
    switch (index) {
      case 0:
        return 1;
      case 1:
        return 0;
      case 2:
        return 3;
      case 3:
        return 2;
    }
    return 0;
  }
}
