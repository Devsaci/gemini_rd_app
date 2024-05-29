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
            icon: const Icon(Icons.image),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              focusNode: textFieldFocus,
              controller: texteController,
              textInputAction: TextInputAction.send,
              onSubmitted: (String value) {},
              decoration: const InputDecoration.collapsed(
                hintText: 'Enter  a promt...',
                border: OutlineInputBorder(),
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
