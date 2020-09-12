
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/authentication/anthentication.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/screen/SignUpPage.dart';
import 'package:googleauth/screen/root_page.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController useremail=TextEditingController();
  TextEditingController userpassword= TextEditingController();

  BaseAuth baseAuth;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {
        FirebaseAuth.instance
            .authStateChanges()
            .listen((User user) {
          if (user == null) {
            print('User is currently signed out!');
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RootPage()));
            print('User is signed in!');
          }
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: gColor,
        onPressed: (){},
        child: Text('Skip'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: size.height,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    width: 200,
                    child: Image.asset('images/logo.png',),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // color: gColor,
                        border: Border.all(color: gColor)),
                    child: TextField(
                      controller: useremail,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: gColor,
                          ),
                          hintText: 'Your Email',
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: gColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                     controller: userpassword,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: gColor,
                          ),
                          suffixIcon: Icon(Icons.visibility),
                          hintText: 'Your Password',
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 40,
                    width: size.width * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: FlatButton(
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: gColor,
                        onPressed: () {
                          // print(useremail.value.toString());

                          loginwithEmail(useremail.text.toString(), userpassword.text.toString());

                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User user) {
                            if (user == null) {
                              print('User is currently signed out!');
                            } else {
                              print('User is signed in!');
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>RootPage()
                              ));
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account?",
                        style:
                            TextStyle(color: Colors.green, fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: (){Navigator.push(context,MaterialPageRoute(
                          builder: (context)=>SignUp()
                        ));},
                        child: Text(
                          '  Sign Up',
                          style:
                              TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OrDivider(),
                  SocialIcon()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 1, color: Colors.green)),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'OR',
              style: TextStyle(color: Colors.green),
            ),
          ),
          Expanded(child: Divider(thickness: 1, color: Colors.green)),
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(10),
            border: Border.all(color: gColor)
          ),
          width: 50,
          height: 50,
          child: SvgPicture.asset('images/facebook.svg'),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: gColor)
        ),
        width: 50,
        height: 50,
        child: SvgPicture.asset('images/phone.svg'),
      ),
      GestureDetector(
        onTap: (){signInWithGoogle();},
        
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: gColor)
          ),
          width: 50,
          height: 50,
          child: SvgPicture.asset('images/google-plus.svg'),
        ),
      ),

    ],
    );
  }
}

