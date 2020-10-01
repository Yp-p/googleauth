import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:googleauth/dark_mode/dark_setting.dart';
import 'package:googleauth/page/busprice.dart';
import 'package:googleauth/page/divisionPage.dart';
import 'package:googleauth/provider/theme_provider.dart';
import 'package:googleauth/screen/root_page.dart';
import 'package:provider/provider.dart';

import 'authentication/anthentication.dart';
import 'authentication/quizPage.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context)=>DarkSetting(),)
        ],
        child: App(),
      )
      );
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  MyTheme currentTheme=MyTheme();

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
    currentTheme.addListener(() {
      print('change');
      setState(() {

      });
    });
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

    return Consumer<DarkSetting>(
      builder: (context, darkSetting, child){
        return MaterialApp(

          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: darkSetting.currentTheme(),
          initialRoute: '/',
          routes: {
            '/' :(context)=> RootPage(auth: Auth(),),
            '/division':(context)=> Division(),
            '/quiz':(context)=> QuizPage(),
            '/busPrice' :(context) =>BusPrice(),

          },

        );

      },);


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
      theme: ThemeData.dark(),


      home: Scaffold(

        body: Container(
          child: Text('hhhhh'),
        ),
      ),
    );
  }
}

