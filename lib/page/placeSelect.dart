import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:googleauth/item/placeItem.dart';
import 'package:googleauth/model/placemodel.dart';
import 'package:googleauth/page/divisionPage.dart';
import 'package:googleauth/model/allplaceModel.dart';
import 'package:googleauth/page/placeDetail.dart';

class PlaceSelect extends StatefulWidget {
  final String divName;

  const PlaceSelect({Key key, this.divName}) : super(key: key);


  @override
  _PlaceSelectState createState() => _PlaceSelectState();
}

class _PlaceSelectState extends State<PlaceSelect> {

TextEditingController _controller=TextEditingController();
Future resultLoad;
List allResult=[];
List _resultList=[];

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    resultLoad=getDoc();
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(_onSearchChanged);
  }




_onSearchChanged(){
  searchResultList();
  print(_controller.text);
}

getDoc() async{
  CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');

  var data=await users.where('state',isEqualTo: widget.divName).get();

  setState(() {
    allResult=data.docs;
  });
searchResultList();
  return 'complete';
}

searchResultList(){
  var showResult=[];

  if(_controller.text!=''){
    for(var placeSnapshot in allResult){
      var placeName=Place.fromSnapshot(placeSnapshot).placeName;
      if(placeName.contains(_controller.text)){
        showResult.add(placeSnapshot);
      }

    }

  }else{
    showResult=List.from(allResult);

  }
  setState(() {
    _resultList=showResult;
  });


}


  @override
  Widget build(BuildContext context) {



    return Scaffold(


      body: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(top: 150),
              child:GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, childAspectRatio: 1.3),
                itemCount: _resultList.length,
                itemBuilder: (context, index) {
                  return Item(data: _resultList[index].data());
                },
              )),

              // PlaceItem(state: widget.divName,)),
          Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: gColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
              ),

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Text(widget.divName, style: TextStyle(color: Colors.white,fontSize: 20),)
                ],
              ),
            ),

          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 110,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                     controller: _controller,
                      decoration: InputDecoration(
                        hintText: "သွားလည်ချင်သော နေရာကို ရှာပါ",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.circular(30),
                          child: Icon(Icons.search),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],

      ),

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
