import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/services/firebase_provider.dart';
import 'package:flash_chat/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String email = "";
  String pass = "";
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final FirebaseService authInstance = Provider.of<FirebaseService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextFormField(
                validator: (value) =>
                    !value!.contains('@') ? "Enter valid Email Address" : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
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
                  setState(() {
                    pass = value;
                  });
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
                buttonText: 'Login',
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    await authInstance.signInWithEmailPassword(email, pass);
                    return;
                  } else {
                    return;
                  }
                },
                buttonColor: Colors.blueAccent,
              ),
              const Text(
                "Don't Have An Account?",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
