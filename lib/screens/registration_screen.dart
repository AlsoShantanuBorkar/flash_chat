import 'package:flash_chat/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Enter Your Email",
              ),
              keyboardType: TextInputType.emailAddress,
              
            ),
            const SizedBox(
              height: 8.0,
            ),
             TextField(
              onChanged: (value) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Enter Your Password",
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomButton(
                buttonText: 'Register',
                onPressed: () {},
                buttonColor: Colors.lightBlueAccent),
          ],
        ),
      ),
    );
  }
}
