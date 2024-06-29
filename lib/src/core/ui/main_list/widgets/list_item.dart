import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/user/user.dart';
import '../../../models/chat_model/chat.dart';
import '../../chat/pages/chat.dart';

class ListItem extends StatelessWidget {
  final User user;
  final User reviever;

  const ListItem({super.key, required this.user, required this.reviever});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(user: user, reciever: reviever),
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
                const Row(
                  children: [
                    Text(
                      'you',
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.black,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            const Text(
              'Вчера',
              style: TextStyle(
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
