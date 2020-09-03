import 'package:flutter/material.dart';
import 'package:googleauth/model/divisionModel.dart';
import 'package:googleauth/model/placemodel.dart';
import 'package:googleauth/page/placeDetail.dart';
import 'package:googleauth/page/placeSelect.dart';
class PlaceItem extends StatelessWidget {
  const PlaceItem({
    Key key,
    @required List<PlaceModel> divisionList,
  }) : _placeList = divisionList, super(key: key);

  final List<PlaceModel> _placeList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: 1.3),
        itemCount: _placeList.length,
        itemBuilder: (context, index) {
          PlaceModel placeModel = _placeList[index];
          return InkWell(
            onTap: (){
              var division= placeModel.name;
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>PlaceDetail()
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
                      placeModel.image,
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
                    child: Text(
                      placeModel.name,
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
  }
}