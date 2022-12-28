import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final FirebaseService firebaseInstance;

  const Chat({super.key, required this.firebaseInstance});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebaseInstance.getSnapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final List<ChatBubble> message =
              firebaseInstance.getMessages(snapshot);
          return ListView(
            shrinkWrap: true,
            children: message,
          );
        }
        return const Text("No Messages");
      }),
    );
  }
}
