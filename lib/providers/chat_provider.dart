class ChatProvider {
  static final ChatProvider _chatProvider = ChatProvider._internal();
  factory ChatProvider() {
    return _chatProvider;
  }
  ChatProvider._internal();
}
