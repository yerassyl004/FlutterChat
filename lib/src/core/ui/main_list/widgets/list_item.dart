import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/user/user.dart';
import '../../../models/message/message.dart';
import '../../chat/pages/chat.dart';

class ListItem extends StatelessWidget {
  final User user;
  final User receiver;
  final Message? lastMessage;

  const ListItem({super.key, required this.user, required this.receiver, this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(user: user, reciever: receiver),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: CupertinoColors.separator),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              child: Image.asset(
                'assets/images/profile.png',
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                lastMessage != null && lastMessage!.senderId == user.id ?
                Row(
                  children: [
                    const Text(
                      'Вы:',
                      style: TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.black,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      lastMessage != null ? lastMessage!.text : 'No messages',
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                )
                    : Text(
                  lastMessage != null ? lastMessage!.text : 'No messages',
                  style: const TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              lastMessage != null
                  ? DateFormat('hh:mm').format(lastMessage!.timestamp)
                  : '',
              style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
