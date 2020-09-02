import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/screen/root_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController userEmail= TextEditingController();
  TextEditingController userPassowd= TextEditingController();
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
    Size size= MediaQuery.of(context).size;
    return Scaffold(
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
                    margin: EdgeInsets.all(10),
                    child: Text('Creat New Account', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),),
                  ),
                  Container(

                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // color: gColor,
                        border: Border.all(color: gColor)),
                    child: TextField(

                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.perm_contact_calendar,
                            color: gColor,
                          ),
                          hintText: 'Your Name',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(child: Text(''),width: 10,),

                  Container(

                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // color: gColor,
                        border: Border.all(color: gColor)),
                    child: TextField(
                      controller: userEmail,

                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: gColor,
                          ),
                          hintText: 'Your Email',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(child: Text(''),width: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: gColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                      controller: userPassowd,
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
                  SizedBox(child: Text(''),width: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: gColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: gColor,
                          ),
                          suffixIcon: Icon(Icons.visibility),
                          hintText: 'Confirm Password',
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
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: gColor,
                        onPressed: () {
                          signInWithEmail(userEmail.text.toString(), userPassowd.text.toString());
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
                        "Already have account?",
                        style:
                        TextStyle(color: Colors.green, fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: (){Navigator.pop(context);},
                        child: Text(
                          '  Sign In',
                          style:
                          TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
