import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:chat_flutter/src/core/models/message/message.dart';
import 'package:chat_flutter/src/core/models/user/user.dart';
import 'package:chat_flutter/src/core/models/chat_model/chat.dart';
import 'package:chat_flutter/src/core/bloc/chat_service/chat_service.dart';
import '../widgets/chat_header.dart';

class ChatPage extends StatefulWidget {
  final User user;
  final User reciever;

  const ChatPage({super.key, required this.user, required this.reciever});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ChatService _chatService = ChatService();
  late Chat _chat;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() async {
    try {
      print('Initializing chat for user: ${widget.user.id}');
      User currentUser = widget.user;
      User reciever = widget.reciever;

      Chat chat = await _chatService.createChat(currentUser, reciever);
      print('Chat initialized: ${chat.id}');

      // Mark messages as read
      await _chatService.markMessagesAsRead(chat.id, currentUser.id);

      // Fetch updated chat
      Chat updatedChat = await _chatService.createChat(currentUser, reciever);

      setState(() {
        _chat = updatedChat;
        _isLoading = false;
      });
    } catch (e) {
      print('Error initializing chat: $e');
    }
  }

  void _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        print('file: ${file.name}');
      } else {
        print('File picking cancel');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String _reciverId() {
    switch (widget.user.id) {
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

  void _sendMessage() {
    try {
      String message = _controller.text.trim();
      if (message.isNotEmpty) {
        Message newMessage = Message(
          id: DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          senderId: widget.user.id,
          receiverId: _reciverId(),
          text: message,
          timestamp: DateTime.now(),
        );
        _chatService.sendMessage(_chat.id, newMessage);
        print('message: $message');
        _controller.clear();
        setState(() {
          _chat.messages.add(newMessage);
        });
      }
    } catch (e) {
      print('Error sending: $e');
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isNextMessageFromCurrentUser(int currentIndex) {
    if (currentIndex + 1 >= _chat.messages.length) {
      return false;
    }
    final currentMessage = _chat.messages[currentIndex];
    final nextMessage = _chat.messages[currentIndex + 1];
    return currentMessage.senderId == nextMessage.senderId;
  }

  bool _isPreviousMessageFromCurrentUser(int currentIndex) {
    if (currentIndex - 1 < 0) {
      return false;
    }
    final currentMessage = _chat.messages[currentIndex];
    final previousMessage = _chat.messages[currentIndex - 1];
    return currentMessage.senderId == previousMessage.senderId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ChatHeader(user: widget.user),
      ),
      body: Column(
        children: [
          Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _chat.messages.length,
                itemBuilder: (context, index) {
                  final message = _chat.messages[index];
                  final isCurrentUser = message.senderId == widget.user.id;
                  final isNextMessageFromCurrentUser = _isNextMessageFromCurrentUser(index);
                  final isPreviousMessageFromCurrentUser = _isPreviousMessageFromCurrentUser(index);

                  // Check message in one day or not
                  bool showDateDivider = index == 0 ||
                      !_isSameDay(message.timestamp,
                          _chat.messages[index - 1].timestamp);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showDateDivider)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                color: Colors.white,
                                child: Text(
                                  DateFormat('dd.MM.yy').format(
                                      message.timestamp),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16.0),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? Colors.green.shade300
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topLeft: !isCurrentUser && isPreviousMessageFromCurrentUser ?
                              Radius.circular(isNextMessageFromCurrentUser ? 23.0 : 8) :
                              const Radius.circular(21.0),

                              topRight: isCurrentUser && isPreviousMessageFromCurrentUser ?
                              Radius.circular(isNextMessageFromCurrentUser ? 23.0 : 8) :
                              const Radius.circular(21.0),
                              bottomLeft: Radius.circular(
                                  isCurrentUser ? 21.0 : 0),
                              bottomRight: Radius.circular(
                                  isCurrentUser ? 0 : 21.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      message.text,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    DateFormat('hh:mm').format(
                                        message.timestamp),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  if (isCurrentUser)
                                  Image.asset(
                                     message.isRead ?
                                    'assets/images/read.png' :
                                    'assets/images/unread.png',
                                    width: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Сообщение',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
