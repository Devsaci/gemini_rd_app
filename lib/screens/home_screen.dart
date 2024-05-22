import 'package:flutter/material.dart';

import 'chat_history_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // list of screens
  final List<Widget> _screens = [
    const ChatHistoryScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _screens,
      ),
    );
  }
}
