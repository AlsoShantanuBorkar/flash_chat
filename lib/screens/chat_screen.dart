import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/services/firebase_provider.dart';
import 'package:flash_chat/widgets/send_message_box.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:http/http.dart';
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
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: firebaseInstance.getSnapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final List<ListTile> message =
                      getMessages(snapshot) as List<ListTile>;
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

  List getMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    // ignore: unnecessary_cast
    final List messages = snapshot.data!.docs
        .map((doc) => ListTile(
            title: Text(doc["text"]),
            subtitle: Text('From: ${doc["sender"].toString()}')))
        .toList();
    return messages;
  }
}
