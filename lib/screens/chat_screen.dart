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
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            title: const Text('Chat with Gemini'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: chatProvider.inChatMessages.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.inChatMessages[index];
                      return ListTile(
                        title: Text(message.message.toString()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
