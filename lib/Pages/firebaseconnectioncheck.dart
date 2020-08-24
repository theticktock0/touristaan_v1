import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),

      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            child: Text("error"),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Text("connected"),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          child: Text("Waiting for initializing to comeplete"),
        );
      },
    );
  }
}