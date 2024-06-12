import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gemini_rd_app/providers/chat_provider.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({
    super.key,
    required this.chatProvider,
  });
  final ChatProvider chatProvider; // reference to the chat provider

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  // focus node for the input field
  FocusNode textFieldFocus = FocusNode();
  // controller for the input field
  final TextEditingController textController = TextEditingController();
  @override
  void dispose() {
    textFieldFocus.dispose();
    textController.dispose();
    super.dispose();
  }

  Future<void> sendChatMessage({
    required String message,
    required ChatProvider chatProvider,
    required bool isTextOnly,
  }) async {
    try {
      // send the chat message
      await chatProvider.sentMessage(
        message: message,
        isTextOnly: isTextOnly,
      );
    } catch (e) {
      log('error : $e');
    } finally {
      textController.clear();
      textFieldFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).textTheme.titleLarge!.color!,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              //Pick Image
            },
            icon: const Icon(Icons.image),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              focusNode: textFieldFocus,
              controller: textController,
              textInputAction: TextInputAction.send,
              onSubmitted: (String value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Enter  a promt...',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (textController.text.isNotEmpty) {
                //Send Image
                sendChatMessage(
                  message: textController.text,
                  chatProvider: widget.chatProvider,
                  isTextOnly: true,
                );
              }
              //Send Image
              sendChatMessage(
                message: textController.text,
                chatProvider: widget.chatProvider,
                isTextOnly: true,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(5.0),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_upward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
