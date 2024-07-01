import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/user/user.dart';
import '../../../models/message/message.dart';
import '../../chat/pages/chat.dart';

class ListItem extends StatelessWidget {
  final User user;
  final User receiver;
  final Message? lastMessage;

  const ListItem({
    super.key,
    required this.user,
    required this.receiver,
    this.lastMessage,
  });

  String getCustomTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Только что';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} минуты назад';
    } else if (difference.inHours < 24 && now.day == timestamp.day) {
      return DateFormat('hh:mm').format(timestamp);
    } else if (difference.inHours < 48 && now.day != timestamp.day) {
      return 'Вчера';
    } else {
      return DateFormat('dd MMM yyyy').format(timestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    String customTimestamp = lastMessage != null
        ? getCustomTimestamp(lastMessage!.timestamp)
        : '';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(user: user, receiver: receiver),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 16.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(user.image),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      lastMessage != null && lastMessage!.senderId == user.id
                          ? Row(
                        children: [
                          const Text(
                            'Вы:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              lastMessage!.text,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )
                          : Text(
                        lastMessage != null
                            ? lastMessage!.text
                            : 'No messages',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      customTimestamp,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 2,
              color: Color.fromRGBO(237, 242, 247, 1),
            ),
          ),
        ],
      ),
    );
  }
}
