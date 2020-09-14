import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:googleauth/model/divisionModel.dart';
import 'package:googleauth/model/placemodel.dart';
import 'package:googleauth/page/placeDetail.dart';
import 'package:googleauth/page/placeSelect.dart';
class PlaceItem extends StatelessWidget {

  final String state;

  const PlaceItem({Key key, this.state}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');


    return StreamBuilder<QuerySnapshot>(
      stream: users.where('state',isEqualTo: state).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasData){
          return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: 1.3),
        itemCount: snapshot.data.size,
        itemBuilder: (context, index) {
          Map data= snapshot.data.docs[index].data();
          return InkWell(
            onTap: (){
              var division= data['state'];
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>PlaceDetail(data: data,)
              ));
              
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 700,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: data['image']==null?Image.asset('images/bagan.jpg',fit: BoxFit.cover,):Image.network(
          data['image'],
            fit: BoxFit.cover,
          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 100, 0, 0.3),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  height: 700,

                ),

                Center(
                  child: Container(
                    child: Text(data['placeName'],
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          );
        });

        }else{
          return Text('error');
        }
      },
    );
  }
}