import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/authentication/cloudfirestore/cloudFireStoreModel.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizPage extends StatefulWidget {

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {


  QuerySnapshot querySnapshot;
  Map<String, dynamic> map={};

  List quizResult=[];
  Future resultLoad;


  getDocument() async{
    CollectionReference user=FirebaseFirestore.instance.collection('Quiz').doc('QuizData').collection('Data');
var firebaseList= await  user.get();
setState(() {
  quizResult=firebaseList.docs;
});
return 'complete';
  }

  Place getDataFromSnatshop(DocumentSnapshot documentSnapshot){
    Place place=Place();
    map=documentSnapshot.data();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    resultLoad=getDocument();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocument();

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user != null) {
        print(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rrr ${quizResult}');

    CollectionReference user=FirebaseFirestore.instance.collection('Quiz').doc('QuizData').collection('Data');



    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: ItemWidget(data: quizResult,)));

    // Center(child: StreamWidget(users: user,))));

  }
}

class ItemWidget extends StatefulWidget {

  const ItemWidget({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List data;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {


  int length=0;
  AudioCache audioCache=AudioCache();

  Color bluecolor=Colors.blue.shade100;
  String rightAnswer='';
  int correctCount=0;
  int wrongCount=0;

  Color resultColor(String answer){

    if(rightAnswer==''){
      return bluecolor;
    }else if(rightAnswer==answer){

      return gColor;

    }else{

      return Colors.red;
    }

  }
  void answer(String slectAnswer, String correctAnswer){
    if(slectAnswer==correctAnswer){
      final audioCache1= AudioCache();
      audioCache1.play('correct.wav');
      correctCount++;
    }else{
      final audioCache1= AudioCache();

      audioCache1.play('incrrect.mp3');
      wrongCount++;
    }
  }
  void countIncre(){
    Duration threeSecond= Duration(seconds: 2);
    Future.delayed(threeSecond,(){setState(() {


      if(length<widget.data.length-1){

        length++;
        rightAnswer='';
      }
      else{

        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=>Result()
        ));
      }

    });});

  }
  List indexList;
  void get(){
    indexList = new List<int>.generate(10, (int index) => index); // [0, 1, 4]
    indexList.shuffle();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();

  }

  @override
  Widget build(BuildContext context) {

        if(widget.data.length!=0){
          return new ListView.builder(
              itemCount: 1 ,
              itemBuilder: (context,index){
                var document=widget.data[indexList[length]];

                return Container(

                  margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${document.data()['question']}',textAlign: TextAlign.center , style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 18,

                        ),),
                        SizedBox(height: 60,),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: RaisedButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () {

                              setState(() {

                                rightAnswer=document.data()['correctAnswer'];
                                // Vibration.vibrate();
                                answer(document.data()['correctAnswer'], document.data()['option1']);
                                countIncre();


                              }
                              );
                            },
                            elevation: 5,
                            color: resultColor(document.data()['option1']),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                            ,
                            child: Text('${document.data()['option1']}', style: TextStyle(
                                fontSize: 15
                            ),),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: RaisedButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                              setState(() {

                                rightAnswer=document.data()['correctAnswer'];
                                answer(document.data()['correctAnswer'], document.data()['option2']);
                                countIncre();




                              });
                            },
                            elevation: 5,
                            color: resultColor(document.data()['option2']),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                            ,
                            child: Text('${document.data()['option2']}', style: TextStyle(
                                fontSize: 15
                            ),),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: RaisedButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                              setState(() {

                                rightAnswer=document.data()['correctAnswer'];
                                answer(document.data()['correctAnswer'], document.data()['option3']);
                                countIncre();
                              });
                            },
                            elevation: 5,
                            color: resultColor(document.data()['option3']),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                            ,
                            child: Text('${document.data()['option3']}', style: TextStyle(
                                fontSize: 15
                            ),),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width*0.9,
                          child: RaisedButton(
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                              setState(() {

                                rightAnswer=document.data()['correctAnswer'];
                                answer(document.data()['correctAnswer'], document.data()['option4']);



                                countIncre();


                              });
                            },
                            elevation: 5,
                            color: resultColor(document.data()['option4']),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                            ,
                            child: Text('${document.data()['option4']}', style: TextStyle(
                                fontSize: 15
                            ),),
                          ),
                        ),


                        RaisedButton(
                          child: Text('အဖြေမှန်- $correctCount နှင့် အဖြေမှား - $wrongCount'),
                          onPressed: (){setState(() {

                            if(length<widget.data.length-1){
                              length++;
                              rightAnswer='';
                            }
                            else{

                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context)=>Result()
                              ));
                            }
                          });},
                        )
                      ],
                    ),
                  ),
                );
              });
        } return CircularProgressIndicator();





  }
  Widget Result(){
    final audioCache1= AudioCache();
    audioCache1.play('cheer.wav');
    return Center(
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,iconTheme: IconThemeData(color: gColor),),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 200,
                    height: 200,
                    child: Image.asset('images/quizlogo.png',)),
                Icon(Icons.check_circle,size: 80, color: gColor,),

                Text('ဂုဏ်ယူပါတယ် \n အောင်မြင်စွာဖြေဆိုပြီးပါပြီး....', textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: gColor),),
                Container(

                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(

                      border: Border.all(color: gColor,)
                  ),
                  child: Column(
                    children: [
                      Text('မေးခွန်းစုစုပေါင်း(၁၀)', style: TextStyle(fontSize: 18,color: Colors.blue),),
                      Text('အဖြေမှန်စုစုပေါင်း = $correctCount', style: TextStyle(fontSize: 15, color: Colors.green),),
                      Text('အဖြေမှားစုစုပေါင်း = $wrongCount', style: TextStyle(fontSize: 15, color: Colors.red),),
                      Text('မဖြေခဲ့သော မေးခွန်း =${10-correctCount-wrongCount}', style: TextStyle(fontSize: 15, color: Colors.black),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
