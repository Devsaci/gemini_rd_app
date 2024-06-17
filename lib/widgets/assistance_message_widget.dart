import 'package:flutter/material.dart';

class AssistantMessageWidget extends StatelessWidget {
  const AssistantMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
    );
  }
}
