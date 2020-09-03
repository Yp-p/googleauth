import 'package:flutter/material.dart';
import 'package:googleauth/model/divisionModel.dart';
import 'package:googleauth/page/placeSelect.dart';

class divisionItem extends StatelessWidget {
  const divisionItem({
    Key key,
    @required List<DivisionModel> divisionList,
  }) : _divisionList = divisionList, super(key: key);

  final List<DivisionModel> _divisionList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: 1.3),
        itemCount: _divisionList.length,
        itemBuilder: (context, index) {
          DivisionModel divisionModel = _divisionList[index];
          return InkWell(
            onTap: (){
              var division= divisionModel.name;
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>PlaceSelect(divName: division,)
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
                      divisionModel.image,
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
                      divisionModel.name,
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