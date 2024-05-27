import 'package:flutter/material.dart';
import 'package:gemini_rd_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, ChatProvider chatProvider, child) {
      return const Scaffold(
        body: Center(
          child: Text("Chat Screen"),
        ),
      );
    });
  }
}
