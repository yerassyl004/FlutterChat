import 'package:flutter/material.dart';
import 'package:chat_flutter/src/core/models/user/user.dart';

class ChatHeader extends StatelessWidget {
  final User user;
  final VoidCallback onBackPressed;

  const ChatHeader({
    super.key,
    required this.user,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              IconButton(
                icon: Image.asset('assets/images/arrow_left.png'),
                onPressed: onBackPressed,
              ),
              const SizedBox(height: 74),
              const SizedBox(width: 6),
              CircleAvatar(
                radius: 25.0,
                child: Image.asset(
                  user.image,
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
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 1,
            color: Color.fromARGB(237, 242, 247, 255),
          ),
        ],
      )
    );
  }
}
