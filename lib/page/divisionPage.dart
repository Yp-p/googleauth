import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/item/divisionItem.dart';
import 'package:googleauth/model/divisionModel.dart';
import 'package:googleauth/page/CategoryPage.dart';
import 'package:googleauth/page/addPlace.dart';
import 'package:googleauth/page/placeSelect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleauth/screen/logInPage.dart';

class Division extends StatefulWidget {
  @override
  _DivisionState createState() => _DivisionState();
}

class _DivisionState extends State<Division> {
  final List<DivisionModel> _divisionList = [
    DivisionModel(image: 'images/shwedagon.jpeg', name: 'ရန်ကုန်တိုင်းဒေသကြီး'),
    DivisionModel(
        image: 'images/division/ngwesaung.jpg', name: 'ဧရာ၀တီတိုင်းဒေသကြီး'),
    DivisionModel(image: 'images/bagan.jpg', name: 'မန္တလေးတိုင်းဒေသကြီး'),
    DivisionModel(
        image: 'images/division/bago.jpg', name: 'ပဲခူးတိုင်းဒေသကြီး'),
    DivisionModel(
        image: 'images/division/magwe.jpg', name: 'မကွေးတိုင်းဒေသကြီး'),
    DivisionModel(
        image: 'images/division/sagaing.jpg', name: 'စစ်ကိုင်းတိုင်းဒေသကြီး'),
    DivisionModel(
        image: 'images/division/thanintharyi.jpg',
        name: 'တနင်္သာရီတိုင်းဒေသကြီး'),
    DivisionModel(image: 'images/division/kachin.jpg', name: 'ကချင်ပြည်နယ်'),
    DivisionModel(image: 'images/division/kaya.jpg', name: 'ကယားပြည်နယ်'),
    DivisionModel(image: 'images/division/kayin.jpg', name: 'ကရင်ပြည်နယ်'),
    DivisionModel(image: 'images/division/mon.jpg', name: 'မွန်ပြည်နယ်'),
    DivisionModel(image: 'images/division/rakhine.jpg', name: 'ရခိုင်ပြည်နယ်'),
    DivisionModel(image: 'images/division/shan.jpg', name: 'ရှမ်းပြည်နယ်'),
    DivisionModel(image: 'images/division/chin.jpg', name: 'ချင်းပြည်နယ်'),
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var user = firebaseAuth.currentUser;

    return Scaffold(
      floatingActionButton: FlatButton(
        onPressed: () {
          user == null
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('အကောင့် မဝင်ထားသည့်အတွက် မရနိုင်ပါ'),
                      actions: [
                        RaisedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>LogInPage()
                            ));
                          },
                          child:Text('အကောင့်ဝင်ရန်') ,
                        ),
                        RaisedButton(
                          onPressed:(){Navigator.pop(context);} ,
                          child: Text('ဟုတ်ပြီး'),
                        )
                      ],
                    );
                  })
              : Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPlace()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: gColor,
        child: Text(
          'နေရာအသစ် ထပ်ထည့်မည်',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: divisionItem(),
    );
  }
}
