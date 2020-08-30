import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text('Log in with Google'),
                  color: Colors.teal,
                  onPressed: signInWithGoogle,
                ),
                // FlatButton(
                //   child: Text('Log in with Facebook'),
                //   color: Colors.teal,
                //   onPressed: signInWithFacebook,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {


    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('hhh');

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//   Future<UserCredential> signInWithFacebook() async {
//     // Trigger the sign-in flow
//     final LoginResult result = await FacebookAuth.instance.login();
//
//     // Create a credential from the access token
//     final FacebookAuthCredential facebookAuthCredential =
//     FacebookAuthProvider.credential(result.accessToken.token);
//
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//   }
}