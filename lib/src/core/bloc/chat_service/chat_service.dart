import '../../models/chat_model/chat.dart';
import '../../models/message/message.dart';
import '../../models/user/user.dart';

class ChatService {
  final List<Chat> _chats = [];

  Future<Chat> createChat(User user1, User user2) async {
    // Simulate a network/database call
    await Future.delayed(Duration(seconds: 1));

    // Check if chat between these users already exists
    Chat? existingChat = _chats.firstWhere(
          (chat) => chat.messages.any((message) =>
      (message.senderId == user1.id && message.receiverId == user2.id) ||
          (message.senderId == user2.id && message.receiverId == user1.id)),
      orElse: () => Chat(id: DateTime.now().millisecondsSinceEpoch.toString(), messages: []),
    );

    if (existingChat != null) {
      return existingChat;
    }

    // Create new chat
    Chat newChat = Chat(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      messages: [],
    );
    _chats.add(newChat);
    return newChat;
  }

  void sendMessage(String chatId, Message message) {
    Chat? chat = _chats.firstWhere((chat) => chat.id == chatId, orElse: () => Chat(id: '', messages: []));
    if (chat.id.isNotEmpty) {
      chat.messages.add(message);
    }
  }
}
