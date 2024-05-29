import 'package:flutter/material.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({super.key});

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  var textFieldFocus;

  var texteController;

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
            onPressed: () {},
            icon: const Icon(Icons.emoji_emotions),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              focusNode: textFieldFocus,
              controller: texteController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}
