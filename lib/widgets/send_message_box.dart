
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMessageBox extends StatefulWidget {
  const SendMessageBox({super.key});

  @override
  State<SendMessageBox> createState() => _SendMessageBoxState();
}

class _SendMessageBoxState extends State<SendMessageBox> {
  final GlobalKey<FormState> _messageForm = GlobalKey<FormState>();
  TextEditingController? messageController;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseInstance =
        Provider.of<FirebaseService>(context);

    return Form(
      key: _messageForm,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: messageController,
                  validator: (value) =>
                      value!.isEmpty ? "Please Enter a Valid Message" : null,
                  decoration: const InputDecoration(border: UnderlineInputBorder()),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //Implement send functionality.
                if (_messageForm.currentState!.validate()) {
                  await firebaseInstance.sendMessage(messageController!.text);
                  messageController!.text = "";
                }
              },
              child: const Text(
                'Send',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
