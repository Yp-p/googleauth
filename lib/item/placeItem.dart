import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:googleauth/model/divisionModel.dart';
import 'package:googleauth/model/placemodel.dart';
import 'package:googleauth/page/placeDetail.dart';
import 'package:googleauth/page/placeSelect.dart';
class PlaceItem extends StatefulWidget {

  final String state;

  const PlaceItem({Key key, this.state}) : super(key: key);

  @override
  _PlaceItemState createState() => _PlaceItemState();
}




class _PlaceItemState extends State<PlaceItem> {
  String onValue='က';
  CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');
  Stream<QuerySnapshot> stream(){
    if(onValue==null){
      return users.where('state',isEqualTo: widget.state).snapshots();
    }else{
      return users.where('placeName',arrayContains: 'ရွှေတိဂုံစေတီတော်').snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    

    
    CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');


    return StreamBuilder<QuerySnapshot>(
      stream: stream(),
      // users.where('state',isEqualTo: widget.state).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasData){
          return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: 1.3),
        itemCount: snapshot.data.size,
        itemBuilder: (context, index) {
          Map data= snapshot.data.docs[index].data();
          return Item(data: data);
        });

        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Item extends StatefulWidget {
  const Item({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Map data;



  @override
  _ItemState createState() => _ItemState();
}


class _ItemState extends State<Item> {
  String photoUrl;
  Future downLoadImage() async{
    StorageReference storageReference=FirebaseStorage.instance.ref().child('placeImage/${widget.data['placeName']}');
    String imageUrl=await storageReference.getDownloadURL();

    setState(() {
      photoUrl=imageUrl;
    });
  }


  @override
  Widget build(BuildContext context) {


    downLoadImage();



    return InkWell(
      onTap: (){
        var division= widget.data['state'];
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>PlaceDetail(data: widget.data,)
        ));

      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 700,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: photoUrl==null?Image.asset('images/bagan.jpg',fit: BoxFit.cover,):Image.network(
    photoUrl,
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
              child: Text(widget.data['placeName'],
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
  }
}