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
                  margin: EdgeInsets.only(top: 280),
                  child: divisionItem()),
              Container(
                color: gColor,
                width: MediaQuery.of(context).size.width,
                height: 100,
               

              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 60,),
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
                          borderRadius: BorderRadius.circular(20)
                        ),
                        margin: EdgeInsets.all(10),
                        color: Colors.green.shade200,
                        child: Container(

                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(10),
                          color: Colors.white,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('မြန်မာနိုင်ငံ၏ မြို့တော်အမည်ကို ရွေးချယ်ပါ။', style: TextStyle(
                                fontSize: 15
                              ),)
                            ],
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