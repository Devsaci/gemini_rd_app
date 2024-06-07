import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gemini_rd_app/api/api_service.dart';
import 'package:gemini_rd_app/constants.dart';
import 'package:gemini_rd_app/hive/chat_history.dart';
import 'package:gemini_rd_app/hive/settings.dart';
import 'package:gemini_rd_app/hive/user_model.dart';
import 'package:gemini_rd_app/models/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
// list of messages
  List<Message> _inChatMessages = [];

  // page controller
  PageController _pageController = PageController();

  // images Xfile list

  List<XFile>? _imagesFileList = [];
  List<XFile>? get imagesFileList => _imagesFileList;
  // List<XFile>? get imagesFileList => this._imagesFileList;

  // set imagesFileList(List<XFile>? value) => this._imagesFileList = value;

  // index of the current screen
  int _currentIndex = 0;

  // cuttent chatId
  String _currentChatId = '';

  // initialize generative model
  GenerativeModel? _model;

  // itialize text model
  GenerativeModel? _textModel;

  // initialize vision model
  GenerativeModel? _visionModel;

  // current mode
  String _modelType = 'gemini-pro';

  // loading bool
  bool _isLoading = false;

  // getters
  List<Message> get inChatMessages => _inChatMessages;
  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex;
  String get currentChatId => _currentChatId;
  GenerativeModel? get model => _model;
  GenerativeModel? get textModel => _textModel;
  GenerativeModel? get visionModel => _visionModel;
  String get modelType => _modelType;
  bool get isLoading => _isLoading;

  // SETTERS

  // set inChatMessages
  Future<void> setInChatMessages({required String chatId}) async {
    // get messages from hive database
    final messagesFromDB = await loadMessagesfromDB(chatId: chatId);
    for (var message in messagesFromDB) {
      if (_inChatMessages.contains(message)) {
        log('message already exist');
        continue;
      }

      _inChatMessages.add(message);
    }

    notifyListeners();
  }

  // Load the messages from hive
  Future<List<Message>> loadMessagesfromDB({required String chatId}) async {
    // open the box of this chatID
    await Hive.openBox<ChatHistory>('${Constants.chatMessagesBox}$chatId');
    final messageBox = Hive.box('${Constants.chatMessagesBox}$chatId');

    // get all the messages
    final newData = messageBox.keys.map((e) {
      final message = messageBox.get(e);
      final messageData = Message.fromMap(Map<String, dynamic>.from(message));
      return messageData;
    }).toList();
    notifyListeners();

    return newData;
  }

  // set file list
  void setImagesFileList({required List<XFile> listValue}) {
    _imagesFileList = listValue;
    notifyListeners();
  }

  // set the current model
  String setCurrentModel({required String newModel}) {
    _modelType = modelType;
    notifyListeners();
    return newModel;
  }

  // function to set the model based on bool - isTextOnly
  Future<void> setModel({required bool isTextOnly}) async {
    if (isTextOnly) {
      _model = _textModel ??
          GenerativeModel(
            model: setCurrentModel(newModel: 'gemini-pro'),
            apiKey: ApiService.geminiApiSecret,
          );
    } else {
      _model = _visionModel ??
          GenerativeModel(
            model: setCurrentModel(newModel: 'gemini-pro-vision'),
            apiKey: ApiService.geminiApiSecret,
          );
    }
    notifyListeners();
  }

  // set current page index
  void setCurrentIndex({required int newIndex}) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  // set current chat id
  void setCurrentChatId({required String newChatId}) {
    _currentChatId = newChatId;
    notifyListeners();
  }

  // set loading
  void setLoading({required bool value}) {
    _isLoading = value;
    notifyListeners();
  }

// send message to gemini and get the streamed reposnse
  Future<void> sentMessage({
    required String message,
    required bool isTextOnly,
  }) async {
    // set the model
    await setModel(isTextOnly: isTextOnly);

    // set loading
    setLoading(value: true);

    // get the chatId
    String chatId = getChatId();

    // list of history messages
    List<Content> history = [];

    // get the chat history
    history = await getHistory(chatId: chatId);

    // get the imagesUrls
    List<String> imagesUrls = getImagesUrls(isTextOnly: isTextOnly);

    // user message
    final userMessage = Message(
      messageId: 'userMessageId.toString()',
      chatId: 'chatId',
      role: Role.user,
      message: StringBuffer(Message),
      imagesUrls: imagesUrls,
      timeSent: DateTime.now(),
    );

    // add this message to the list on inChatMessages
    _inChatMessages.add(userMessage);
    notifyListeners();
    if (currentChatId.isEmpty) {
      setCurrentChatId(newChatId: chatId)
    }
   // send the message to the model and wait for the response
    await sendMessageAndWaitForResponse (
      message: message,
      isTextOnly: isTextOnly,
    );
   
    // END SENDING MESSAGE TO GEMINI
  }

  // send message to the model and wait for the response
     Future<void> sendMessageAndWaitForResponse({
      required String message,
      required bool isTextOnly,
      }) async {
       
     }
      

  List<String> getImagesUrls({
    required bool isTextOnly,
  }) {
    List<String> imagesUrls = [];
    if (!isTextOnly && imagesFileList != null) {
      for (var image in imagesFileList!) {
        imagesUrls.add(image.path);
      }
    }
    return imagesUrls;
  }

  Future<List<Content>> getHistory({required String chatId}) async {
    List<Content> history = [];
    if (currentChatId.isNotEmpty) {
      await setInChatMessages(chatId: chatId);
      for (var message in inChatMessages) {
        if (message.role == Role.user) {
          history.add(Content.text(message.message.toString()));
        } else {
          history.add(Content.model([TextPart(message.message.toString())]));
        }
      }
    }

    return history;
  }

  String getChatId() {
    if (_currentChatId.isEmpty) {
      return const Uuid().v4();
    } else {
      return _currentChatId;
    }
  }

  // Init Hive boxe
  static initHive() async {
    final dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter(Constants.geminiDB);

    //REGISTER ADAPTERS
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ChatHistoryAdapter());

      // OPEN CHAT HISTORY BOX
      await Hive.openBox<ChatHistory>(Constants.chatHistoryBox);
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserModelAdapter());
      await Hive.openBox<UserModel>(Constants.userBox);
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SettingsAdapter());
      await Hive.openBox<Settings>(Constants.settingsBox);
    }
  }
}
