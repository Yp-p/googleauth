import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/item/placeItem.dart';
import 'package:googleauth/model/placemodel.dart';
import 'package:googleauth/page/divisionPage.dart';
import 'package:googleauth/model/allplaceModel.dart';

class PlaceSelect extends StatefulWidget {
  final String divName;

  const PlaceSelect({Key key, this.divName}) : super(key: key);

  @override
  _PlaceSelectState createState() => _PlaceSelectState();
}

class _PlaceSelectState extends State<PlaceSelect> {


  @override
  Widget build(BuildContext context) {


    final List<PlaceModel> _divisionList =map[widget.divName];


    return Scaffold(

      body: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(top: 150),
              child: PlaceItem(state: widget.divName,)),
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
