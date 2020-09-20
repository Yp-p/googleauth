import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:googleauth/page/placeDetail.dart';

class SavePage extends StatefulWidget {
  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getStateSaveDatabase();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
            child: Center(child: Text('သိမ်းထားသော ခရီးစဉ်များ'))),
        Expanded(
          child: FutureBuilder(
            future: getAllSaveDatabase(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return ListView.builder(

                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      Place dataMap=snapshot.data[index];
                      return Slidable(

                        key: ValueKey(index),
                        actionPane: SlidableBehindActionPane(),
                        actionExtentRatio: 0.5,

                        actions: <Widget>[
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.blue,
                            icon: Icons.delete,
                            onTap: () { setState(() {
                              deleteSaveDatabase(dataMap.placeName);
                            });
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SavePage()));
                            },
                          ),

                        ],
                        secondaryActions: <Widget>[

                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {setState(() {
                              deleteSaveDatabase(dataMap.placeName);
                            });},
                          ),
                        ],

                        child: InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>PlaceDetail(data: dataMap.toMap(),)
                          ));},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 130,
                                child: Card(
                                  elevation: 5,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding:EdgeInsets.only(left: 5),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: dataMap.image!=null?
                                            Image.network(dataMap.image,
                                              fit: BoxFit.fill,
                                              width: 120,
                                              height: 110,)
                                                :Image.asset('images/bagan.jpg',
                                              fit: BoxFit.fill,
                                              width: 120,
                                              height: 110,),

                                            )),

                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              dataMap.placeName,
                                              style: TextStyle(color: gColor, fontSize: 13),
                                            ),
                                            Text(
                                              dataMap.location!=null?dataMap.location:'အချက်အလက်မရှိသေးပါ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
