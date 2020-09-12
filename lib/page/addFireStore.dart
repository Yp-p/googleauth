import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleauth/database/databaseHelper.dart';

class AddFirestore extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      for(var data in shweDaogon) {
        users.doc(data.placeName).set(data.toMap());
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Text('Add Item'),
          RaisedButton(
            onPressed: (){

              print('haha');
              addUser();
            },
            child: Text('Add Button'),
          )
        ],
      ),
    );
  }
}
