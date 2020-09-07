import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:googleauth/authentication/anthentication.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:googleauth/screen/HomePage.dart';
import 'package:googleauth/screen/logInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';


enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}


class RootPage extends StatefulWidget {
  final BaseAuth auth;

  const RootPage({this.auth});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus= AuthStatus.NOT_DETERMINED;
  String _userID='';

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // for (var place in shweDaogon) {
    //   insertDatabase(place);
    //
    // }

    Firebase.initializeApp().whenComplete((){
      print('complete');
      setState(() {
        FirebaseAuth.instance
            .authStateChanges()
            .listen((User user) {
          if (user == null) {
            print('User is currently signed out!');
            authStatus=AuthStatus.NOT_LOGGED_IN;
          } else {
            authStatus=AuthStatus.LOGGED_IN;
            _userID = user.uid.toString();
            print('User is signed in!');
          }
        });
      });
    });

  }
  //
  // void loginCallback() {
  //   widget.auth.getCurrentUser().then((user) {
  //     setState(() {
  //       _userID = user.uid.toString();
  //     });
  //   });
  //   setState(() {
  //     authStatus = AuthStatus.LOGGED_IN;
  //   });
  // }
  //
  // void logoutCallback() {
  //   setState(() {
  //     authStatus = AuthStatus.NOT_LOGGED_IN;
  //     _userID = "";
  //   });
  // }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LogInPage();
        break;
      case AuthStatus.LOGGED_IN:
        if (_userID.length > 0 && _userID != null) {
          return new HomePage();
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
