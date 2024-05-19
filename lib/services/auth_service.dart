import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagementapp/pages/widgets/widgets.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  userLogin(String email, String password, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      Navigator.pop(context);
      if (user.user != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", user.user!.uid.toString());
        Navigator.pushNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showToastWidget("No user Found for this email");
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("djjsdjhsb")));
      } else if (e.code == "wrong-password") {
        showToastWidget("The password entered is incorrect");
      } else if (e.code == "invalid-email") {
        showToastWidget("Email address is badly formatted");
      } else if (e.code == 'invalid-credential') {
        showToastWidget("No user Found for this email");
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("djjsdjhsb")));
      }
    }
  }

//////////////////////////////////////////////////////////////////////////////////
  userRegistration(String email, String password, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      Navigator.pop(context);
      if (newUser.user != null) {
         final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", newUser.user!.uid.toString());
        Navigator.pushNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // print("error-----------{$e}");
      if (e.code == 'email-already-in-use') {
        showToastWidget("The email is already in use");
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("djjsdjhsb")));
      } else if (e.code == "weak-password") {
        showToastWidget("Password should be at least 6 characters");
      } else if (e.code == "invalid-email") {
        showToastWidget("Email address is badly formatted");
      }
    }
  }

/////////////////////////////////////////////////////////////////////////
  logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
