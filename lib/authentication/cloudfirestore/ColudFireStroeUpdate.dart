import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleauth/authentication/cloudfirestore/cloudFireStoreModel.dart';

class InsertFireStroe extends StatefulWidget {
  @override
  _InsertFireStroeState createState() => _InsertFireStroeState();
}

class _InsertFireStroeState extends State<InsertFireStroe> {
  CollectionReference user=FirebaseFirestore.instance.collection('Quiz').doc('QuizData').collection('Data');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('InsertData'),
        onPressed: (){
          for(var data in cloudList){
            user.add(data.toMap());

          }
        },
      ),
    );
  }
}
