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
    return FutureBuilder(
      future: getStatePlaceDatabase(state),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: 1.3),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              var division= snapshot.data[index].placeName;
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>PlaceDetail(placeName: snapshot.data[index],)
              ));
              
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 700,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                    snapshot.data[index].image,
                      fit: BoxFit.cover,


                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  height: 700,
                  color: Color.fromRGBO(255, 100, 0, 0.3),
                ),

                Center(
                  child: Container(
                    child: Text(snapshot.data[index].placeName,
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