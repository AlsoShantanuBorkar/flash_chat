import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/widgets/chat.dart';
import 'package:flash_chat/widgets/send_message_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseInstance =
        Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async => await firebaseInstance.signOutUser()),
        ],
        title: const Text('⚡️Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Chat(
            firebaseInstance: firebaseInstance,
          ),
          const SendMessageBox(),
        ],
      ),
    );
  }
}
