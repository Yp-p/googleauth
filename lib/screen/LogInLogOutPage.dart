

import 'package:flutter/material.dart';
import 'package:googleauth/provider/loginoutprovider.dart';
import 'package:googleauth/screen/HomePage.dart';
import 'package:googleauth/screen/logInPage.dart';
import 'package:provider/provider.dart';

import 'SignUpPage.dart';

class LoginLogoutPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginOutProvider()),
      ],
      child: LogInOut(),
    );



  }
}

class LogInOut extends StatefulWidget {





  @override
  _LogInOutState createState() => _LogInOutState();
}

class _LogInOutState extends State<LogInOut> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    Provider.debugCheckInvalidValueType = null;

    var data=context.watch<LoginOutProvider>().getSign();
    print(data);
    bool signBool=context.watch<LoginOutProvider>().getSign();
    bool withoutLogin=context.watch<LoginOutProvider>().getWithoutLogIn();
    if(withoutLogin==false){
      return signBool == true ? SignUp() : LogInPage();

    }else {
      return HomePage();
    }

  }
}

