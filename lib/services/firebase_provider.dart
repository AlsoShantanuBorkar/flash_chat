import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth authinstance;
  final FirebaseFirestore firestoreInstance;

  FirebaseService({
    required this.authinstance,
    required this.firestoreInstance,
  });

  Stream<User?> get userState => authinstance.authStateChanges();
  User? get currentUser => authinstance.currentUser;

  Future<void> signOutUser() async => authinstance.signOut();

  Future createAccountWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await authinstance.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await authinstance.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future sendMessage(String message) async {
    await firestoreInstance.collection('messages').add(
      {
        'text': message,
        'sender': currentUser!.email,
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshots() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        firestoreInstance.collection('messages').snapshots();
    return snapshot;
  }
}
