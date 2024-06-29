import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/user/user.dart';

class ChatHeader extends StatelessWidget {
  final User user;
  const ChatHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          child: Image.asset(
            'assets/images/profile.png',
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'В сети',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }
}