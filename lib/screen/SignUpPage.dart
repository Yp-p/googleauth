import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/provider/loginoutprovider.dart';
import 'package:provider/provider.dart';


class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String errorPassword='';
  String errorEmail='';
  bool obscureText=true;

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
                    child: Text('အကောင့်အသစ်ဖန်တီးလိုက်ပါ...', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),),
                  ),
                  // Container(
                  //
                  //   width: size.width * 0.8,
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30),
                  //       // color: gColor,
                  //       border: Border.all(color: gColor)),
                  //   child: TextField(
                  //
                  //     decoration: InputDecoration(
                  //         icon: Icon(
                  //           Icons.perm_contact_calendar,
                  //           color: gColor,
                  //         ),
                  //         hintText: 'Your Name',
                  //         border: InputBorder.none),
                  //   ),
                  // ),
                  SizedBox(child: Text(''),),

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
                          hintText: 'သင့်၏ email ထည့်ပါ',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(child: Text(errorEmail, style: TextStyle(
                    color: Colors.red, fontSize: 13
                  ),)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border.all(color: gColor),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                      obscureText: obscureText,
                      controller: userPassowd,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: gColor,
                          ),
                          suffixIcon: IconButton(
                              onPressed: (){setState(() {
                                obscureText=obscureText==true?false:true;
                              });},
                              icon: Icon(Icons.visibility)),
                          hintText: 'လျှို့ဝှတ်နံပါထည့်ပါ',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(child: Text(errorPassword, style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),),),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                  //   width: size.width * 0.8,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: gColor),
                  //       borderRadius: BorderRadius.circular(30)),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         icon: Icon(
                  //           Icons.lock,
                  //           color: gColor,
                  //         ),
                  //         suffixIcon: Icon(Icons.visibility),
                  //         hintText: 'Confirm Password',
                  //         border: InputBorder.none),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 40,
                    width: size.width * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: FlatButton(
                        child: Text(
                          'အကောင့်ဆောက်မည်',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: gColor,
                        onPressed: () async{


                          var signUp=await signUpWithEmail(userEmail.text.toString(), userPassowd.text.toString());
                          print(signUp);
                          setState(() {
                            errorEmail= signUp=='email-already-in-use'? 'အသုံးပြုပြီးသား email ဖြစ်ပါသည်':'';
                            errorPassword= signUp=='weak-password' ? 'password အနည်းဆုံး(၆)လုံးရိုက်ထည့်ပါ':'';

                            // if (signUp == 'weak-password') {
                            //   errorPassword='password အရမ်းယ်လွန်းသည်';
                            //   print(errorEmail);
                            //
                            //   print('The password provided is too weak.');
                            // } else if (signUp == 'email-already-in-use') {
                            //   errorEmail='အသုံးပြုပြီးသား email ဖြစ်ပါသည်';
                            //   print('The account alrey exists for that email.');
                            // }else{
                            //   print(signUp);
                            //   errorPassword='';
                            //   errorEmail='';
                            // }

                          });



                          // FirebaseAuth.instance
                          //     .authStateChanges()
                          //     .listen((User user) {
                          //   if (user == null) {
                          //     print('User is currently signed out!');
                          //   } else {
                          //     print('User is signed in!');
                          //     Navigator.push(context, MaterialPageRoute(
                          //       builder: (context)=>RootPage()
                          //     ));
                          //   }
                          // });

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
                        "အကောင့်ရှိပြီးသားလား ဖြစ်ပါက",
                        style:
                        TextStyle(color: Colors.green, fontSize: 13),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){

                          context.read<LoginOutProvider>().changeSign();
                          // Navigator.pop(context);
                          },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: gColor)
                          ),

                          child: Text(
                            'နှိပ်ပါ',
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
