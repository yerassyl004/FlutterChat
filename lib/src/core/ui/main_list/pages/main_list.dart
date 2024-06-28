import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../../../models/user/user.dart';
import '../../../models/chat_model/chat.dart';
import '../../../models/message/message.dart';
import '../widgets/header_widget.dart';
import '../widgets/list_item.dart';

class MainList extends StatelessWidget {
  MainList({super.key});

  final storage = const FlutterSecureStorage();

  final List<Message> messages1 = [
    Message(
      id: '1',
      senderId: '1',
      receiverId: '2',
      text: 'Hello Виктор!',
      timestamp: DateTime.now(),
    ),
    Message(
      id: '2',
      senderId: '2',
      receiverId: '1',
      text: 'Hello Саша!',
      timestamp: DateTime.now(),
    ),
  ];

  final List<Message> messages2 = [
    Message(
      id: '3',
      senderId: '3',
      receiverId: '4',
      text: 'Hello Петр!',
      timestamp: DateTime.now(),
    ),
    Message(
      id: '4',
      senderId: '4',
      receiverId: '3',
      text: 'Hello Алина!',
      timestamp: DateTime.now(),
    ),
  ];

  final List<User> users = [
    User(id: '1', name: 'Виктор Власов', chatId: '1'),
    User(id: '2', name: 'Саша Алексеев', chatId: '1'),
    User(id: '3', name: 'Петр Жаринов', chatId: '2'),
    User(id: '4', name: 'Алина Жукова', chatId: '2'),
  ];

  Future<void> _initializeChats() async {
    try {
      final Chat chat1 = Chat(id: '1-2', messages: messages1);
      final Chat chat2 = Chat(id: '3-4', messages: messages2);

      await storage.write(key: chat1.id, value: jsonEncode(chat1.toJson()));
      await storage.write(key: chat2.id, value: jsonEncode(chat2.toJson()));
    } catch (e) {
      print('Error initializing chats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeChats();

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          HeaderWidget(
            title: 'Чаты',
            onSearchChanged: (String value) {},
            onSearchSubmitted: (String value) {},
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListItem(user: users[index]);
              },
              childCount: users.length,
            ),
          ),
        ],
      ),
    );
  }
}
