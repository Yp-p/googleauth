
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleauth/authentication/anthentication.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/provider/loginoutprovider.dart';
import 'package:googleauth/screen/HomePage.dart';
import 'package:googleauth/screen/SignUpPage.dart';
import 'package:googleauth/screen/root_page.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController useremail=TextEditingController();
  TextEditingController userpassword= TextEditingController();
  String errorEmail='';
  String errorPassword='';
  bool loginOnpress=false;

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

  Function signInOnPress() {

      return () async {
        print(useremail.value.toString());

        String error = await loginwithEmail(
            useremail.text.toString(), userpassword.text.toString());
        setState(() {
          if (error == 'invalid-email') {
            errorEmail = 'email ပုံစံမှားနေပါသည်';
          } else if (error == 'user-not-found') {
            errorEmail = 'email မှားနေပါသည်။';
          } else {
            errorEmail = '';
          }

          errorPassword =
          error == 'wrong-password' ? 'လျှို့ဝှတ်နံပါတ် မှားယွင်းနေပါသည်။' : '';
          print(error);
        });
      };



  }


  @override
  Widget build(BuildContext context) {
    print(useremail.text);

    loginOnpress=useremail.text!=''?true:false;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: gColor,
        onPressed: (){

          context.read<LoginOutProvider>().changeWithoutLogIn();
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context)=>HomePage()
          // ));
        },
        child: Text('ကျော်ရန်', style: TextStyle(fontSize: 10),),
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
                    // margin: EdgeInsets.symmetric(vertical: 10),
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
                          hintText: 'သင်၏ email',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(child: Text(errorEmail, style: TextStyle(
                    color: Colors.red,
                    fontSize: 13
                  ),),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: gColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                      obscureText: true,
                     controller: userpassword,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: gColor,
                          ),
                          suffixIcon: Icon(Icons.visibility),
                          hintText: 'လျှို့ဝှတ်နံပါတ်',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(child: Text(errorPassword, style: TextStyle(
                    color: Colors.red,
                    fontSize: 13
                  ),),),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 40,
                    width: size.width * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: RaisedButton(
                        child: Text(
                          'အကောင့်ဝင်မည်',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: gColor,
                        // onPressed: signInOnPress,
                        onPressed:() async{
                          print(useremail.value.toString());

                          String error= await loginwithEmail(useremail.text.toString(), userpassword.text.toString());
                          setState(() {

                            if(error=='invalid-email'){
                              errorEmail='email ပုံစံမှားနေပါသည်';
                            }else if(error=='user-not-found'){
                              errorEmail='email မှားနေပါသည်။';
                            }else{ errorEmail='';}

                            errorPassword = error=='wrong-password'? 'လျှို့ဝှတ်နံပါတ် မှားယွင်းနေပါသည်။':'';
                            print(error);
                          });



                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User user) {
                            if (user == null) {
                              print('User is currently signed out!');
                            } else {
                              print('User is signed in!');
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context)=>RootPage()
                              // ));
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "အကောင့်မဖွင့်ရသေးဘူးလား?",
                        style:
                            TextStyle(color: Colors.green, fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: (){
                          context.read<LoginOutProvider>().changeSign();
                          print(context.read<LoginOutProvider>().getSign());
                        //   Navigator.push(context,MaterialPageRoute(
                        //   builder: (context)=>SignUp()
                        // ));
                          },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: gColor, width: 2)
                          ),
                          child: Text(
                            'အကောင့်အသစ်ဖွင့်ရန်',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 15),
                          ),
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
        onTap: (){
          signInWithGoogle();

          // FirebaseAuth.instance.authStateChanges().listen((event) {print('hhh$event');});
          },
        
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

