import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/item/divisionItem.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          body: Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 180, left: 5, right: 5),
                  child: divisionItem()),

              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 20,),
                  decoration: BoxDecoration(

                  ),

                  child: Column(
                    children: [
                      Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          elevation: 5,

                          child: Container(

                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000)
                            ),
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.satellite,size: 35,),
                                Icon(Icons.queue,size: 35,),
                                Icon(Icons.queue,size: 35,),

                              ],
                            ),
                          ),
                        ),
                      ),


                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        margin: EdgeInsets.all(10),

                        child: Container(

                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),


                          child: Center(
                            child: SizedBox(

                            child: ScaleAnimatedTextKit(
                              totalRepeatCount: 300,
                              duration: Duration(seconds: 3),
                            onTap: () {
                                Navigator.pushNamed(context, '/quiz');
                            print("Tap Event");
                            },
                            text: [

                            "မြန်မာနိုင်ငံအကြောင်း ဘယ်လောက်သိလဲ...",
                              "မေးခွန်းလေးတွေဖြေကြည့်ရန်",
                              "ဒီနေရာကိုနှိပ်ပါ"
                            ],
                            textStyle: TextStyle(
                            fontSize: 17.0,
                            // color: gColor,
                            fontFamily: "Bobbers"
                            ),
                              isRepeatingAnimation: true,
                            textAlign: TextAlign.center,
                            alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                            ),
                            ),
                          ),
                          // child: ,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          )
    );

  }
}