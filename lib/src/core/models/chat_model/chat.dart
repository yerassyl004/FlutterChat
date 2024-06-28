import '../message/message.dart';

class Chat {
  final String id;
  final List<Message> messages;

  Chat({required this.id, required this.messages});
}