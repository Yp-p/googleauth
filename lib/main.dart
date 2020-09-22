import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:googleauth/page/busprice.dart';
import 'package:googleauth/page/divisionPage.dart';
import 'package:googleauth/screen/root_page.dart';

import 'authentication/anthentication.dart';
import 'authentication/quizPage.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if(_error) {
      return SomethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' :(context)=> RootPage(auth: Auth(),),
        '/division':(context)=> Division(),
        '/quiz':(context)=> QuizPage(),
        '/busPrice' :(context) =>BusPrice(),

      },

    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('ERROr');
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class MyAweSomeApp extends StatefulWidget {
  @override
  _MyAweSomeAppState createState() => _MyAweSomeAppState();
}

class _MyAweSomeAppState extends State<MyAweSomeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: Scaffold(
        body: Container(
          child: Text('hhhhh'),
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:googleauth/authentication/quizPage.dart';
// import 'package:googleauth/page/busprice.dart';
// import 'package:googleauth/page/divisionPage.dart';
// import 'package:googleauth/screen/root_page.dart';
// import 'package:googleauth/screen/logInPage.dart';
// import 'authentication/anthentication.dart';
// import 'database/databaseHelper.dart';
//
// void main() {
//   runApp(MyApp());
//
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Firebase.initializeApp().whenComplete((){
//       print('complete');});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // darkTheme: ThemeData.dark(),
//       theme: ThemeData.light(),
//       initialRoute: '/',
//       routes: {
//         '/' :(context)=> RootPage(),
//         '/division':(context)=> Division(),
//         '/quiz':(context)=> QuizPage(),
//         '/busPrice' :(context) =>BusPrice(),
//
//       },
//
//     );
//   }
// }
//
//
// class One extends StatefulWidget {
//
//   @override
//   _OneState createState() => _OneState();
// }
//
// class _OneState extends State<One> {
//   @override
//   void initState() {
//     // for (var place in shweDaogon) {
//     //   insertDatabase(place);
//     //
//     // }
//
//     super.initState();
//     Firebase.initializeApp().whenComplete(() {
//       print("completed");
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     // TODO: implement build
//     return  Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FlatButton(
//               child: Text('Log in with Google'),
//               color: Colors.teal,
//               onPressed: signInWithGoogle
//
//             ),
//             FlatButton(
//               child: Text('Log in with Facebook'),
//               color: Color(0xFFA5D6A7),
//               onPressed: (){
//                 signInWithFacebook();
//
//               }
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//     // Create a new credential
//     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     print('hhh');
//
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//
//   Future<UserCredential> signInWithFacebook() async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: "yy8@example.com",
//           password: "1yyyyyyyyyyyy"
//       );
//
//       FirebaseAuth.instance
//           .authStateChanges()
//           .listen((User user) {
//         if (user == null) {
//           print('User is currently signed out!');
//         } else {
//           print('User is signed in!');
//           Navigator.push(context, MaterialPageRoute(
//               builder: (context)=>Three()
//           ));
//
//         }
//       });
//
//
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//
//   }
//
//
// }
//
// class Three extends StatefulWidget {
//   @override
//   _ThreeState createState() => _ThreeState();
// }
//
// class _ThreeState extends State<Three> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Three'),),
//     );
//   }
// }
//
//
