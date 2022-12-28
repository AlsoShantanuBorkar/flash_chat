import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/services/firebase_provider.dart';
import 'package:flash_chat/widgets/chat_bubble.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              stream: firebaseInstance.getSnapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final List<ChatBubble> message = getMessages(snapshot);
                  return ListView(
                    shrinkWrap: true,
                    children: message,
                  );
                }
                return const Text("No Messages");
              }),
            ),
            const SendMessageBox(),
          ],
        ),
      ),
    );
  }

  List<ChatBubble> getMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    // ignore: unnecessary_cast
    final List<ChatBubble> messages = snapshot.data!.docs
        .map((doc) => ChatBubble(
              sender: doc['sender'],
              text: doc['text'],
              isSenderUser:
                  doc['sender'] == FirebaseAuth.instance.currentUser!.email,
            ))
        .toList();
    return messages;
  }
}
