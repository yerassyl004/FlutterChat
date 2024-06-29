import '../message/message.dart';

class Chat {
  final String id;
  final List<Message> messages;

  Chat({required this.id, required this.messages});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      messages: List<Message>.from(json['messages'].map((item) => Message.fromJson(item))),
    );
  }
}
