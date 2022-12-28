import 'package:flash_chat/services/firebase_provider.dart';
import 'package:flash_chat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  String email = "";
  String pass = "";
  final GlobalKey<FormState> _registrationFromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FirebaseService authInstance = Provider.of<FirebaseService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _registrationFromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextFormField(
                validator: (value) => !value!.contains('@')
                    ? "Please enter a valid Email Address"
                    : null,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter Your Email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                validator: (value) => value!.length < 6
                    ? "Password length must be greater than 6"
                    : null,
                onChanged: (value) {
                  pass = value;
                },
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
                  onPressed: () async =>
                      _registrationFromKey.currentState!.validate()
                          ? {
                              await authInstance.createAccountWithEmailPassword(
                                  email, pass),
                              Navigator.pop(context)
                            }
                          : null,
                  buttonColor: Colors.lightBlueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
