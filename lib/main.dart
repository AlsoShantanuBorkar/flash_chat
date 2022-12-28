import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/widgets/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService authInstance = FirebaseService(
        authinstance: FirebaseAuth.instance,
        firestoreInstance: FirebaseFirestore.instance);
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          initialData: null,
          create: (context) => authInstance.userState,
        ),
        Provider<FirebaseService>(
          create: (context) => authInstance,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flash Chat',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}
