import 'package:flutter/material.dart';

class ChatInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPickFile;
  final VoidCallback onSendMessage;

  const ChatInputWidget({
    super.key,
    required this.controller,
    required this.onPickFile,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 2,
          color: Color.fromRGBO(237, 242, 247, 1),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const SizedBox(width: 20),
            IconButton(
              icon: Image.asset('assets/images/attach.png'),
              color: const Color.fromRGBO(237, 242, 247, 1),
              onPressed: onPickFile,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Сообщение',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: onSendMessage,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
