import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final int index;

  const ListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Chat ${index + 1}',
                style: const TextStyle(
                  fontSize: 18,
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
                      fontSize: 14,
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
    );
  }
}
