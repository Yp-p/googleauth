import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:googleauth/authentication/quizPage.dart';
import 'package:googleauth/page/busprice.dart';
import 'package:googleauth/page/divisionPage.dart';
import 'package:googleauth/screen/root_page.dart';
import 'package:googleauth/screen/logInPage.dart';

import 'database/databaseHelper.dart';

void main() {
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/' :(context)=> RootPage(),
        '/division':(context)=> Division(),
        '/quiz':(context)=> QuizPage(),
        '/busPrice' :(context) =>BusPrice(),

      },

    );
  }
}


class One extends StatefulWidget {

  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
  @override
  void initState() {
    // for (var place in shweDaogon) {
    //   insertDatabase(place);
    //
    // }

    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Text('Log in with Google'),
              color: Colors.teal,
              onPressed: signInWithGoogle

            ),
            FlatButton(
              child: Text('Log in with Facebook'),
              color: Color(0xFFA5D6A7),
              onPressed: (){
                signInWithFacebook();

              }
            )
          ],
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

  Future<UserCredential> signInWithFacebook() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "yy8@example.com",
          password: "1yyyyyyyyyyyy"
      );

      FirebaseAuth.instance
          .authStateChanges()
          .listen((User user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>Three()
          ));

        }
      });


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }

  }


}

class Three extends StatefulWidget {
  @override
  _ThreeState createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Three'),),
    );
  }
}


