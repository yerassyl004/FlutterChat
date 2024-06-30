import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/chat_model/chat.dart';
import '../../models/message/message.dart';
import '../../models/user/user.dart';

class ChatService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<List<Message>> fetchLastMessages(String chatId) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      String? chatJson = await storage.read(key: chatId);
      if (chatJson != null) {
        Map<String, dynamic> chatMap = jsonDecode(chatJson);
        var chat = Chat.fromJson(chatMap);
        return chat.messages;
      } else {
        Chat newChat = Chat(id: chatId, messages: []);
        await saveChat(newChat);
        return [];
      }
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  Future<Message?> getLastMessage(String chatId) async {
    try {
      List<Message> messages = await fetchLastMessages(chatId);
      if (messages.isNotEmpty) {
        return messages.last;
      }
    } catch (e) {
      print('Error fetching last message: $e');
    }
    return null;
  }

  Future<Chat> createChat(User currentUser, User otherUser) async {
    String chatId = generateChatId(currentUser.id, otherUser.id);

    try {
      String? chatJson = await storage.read(key: chatId);
      if (chatJson != null) {
        Map<String, dynamic> chatMap = jsonDecode(chatJson);
        return Chat.fromJson(chatMap);
      } else {
        Chat newChat = Chat(id: chatId, messages: []);
        await saveChat(newChat);
        return newChat;
      }
    } catch (e) {
      print('Error creating chat: $e');
      rethrow;
    }
  }

  Future<void> sendMessage(String chatId, Message message) async {
    try {
      String? chatJson = await storage.read(key: chatId);
      if (chatJson != null) {
        Map<String, dynamic> chatMap = jsonDecode(chatJson);
        Chat chat = Chat.fromJson(chatMap);
        chat.messages.add(message);
        await saveChat(chat);
      } else {
        Chat newChat = Chat(id: chatId, messages: [message]);
        await saveChat(newChat);
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Future<void> saveChat(Chat chat) async {
    try {
      await storage.write(key: chat.id, value: jsonEncode(chat.toJson()));
    } catch (e) {
      print('Error saving chat: $e');
    }
  }

  Future<void> markMessagesAsRead(String chatId, String userId) async {
    try {
      String? chatJson = await storage.read(key: chatId);
      if (chatJson != null) {
        Map<String, dynamic> chatMap = jsonDecode(chatJson);
        Chat chat = Chat.fromJson(chatMap);

        chat.messages = chat.messages.map((message) {
          if (message.receiverId == userId && !message.isRead) {
            return message.markAsRead();
          }
          return message;
        }).toList();

        await saveChat(chat);
      }
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }

  String generateChatId(String userId1, String userId2) {
    return userId1.hashCode <= userId2.hashCode
        ? '$userId1-$userId2'
        : '$userId2-$userId1';
  }
}

