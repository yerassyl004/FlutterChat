import 'package:chat_flutter/src/core/ui/chat/widgets/chat_header.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ChatPage extends StatefulWidget {
  final int index;

  const ChatPage({super.key, required this.index});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      // Handle the file (e.g., upload it or display its name)
      print('Picked file: ${file.name}');
    } else {
      // User canceled the picker
      print('File picking canceled');
    }
  }

  void _sendMessage() {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      // Send the message (e.g., send to the server or display it in the chat)
      print('Sent message: $message');
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ChatHeader(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('This is the chat page for Chat ${widget.index + 1}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
