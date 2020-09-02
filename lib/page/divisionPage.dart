import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/page/CategoryPage.dart';

class DivisionModel {
  final String image;
  final String name;

  DivisionModel({this.image, this.name});
}

class Division extends StatefulWidget {
  @override
  _DivisionState createState() => _DivisionState();
}

class _DivisionState extends State<Division> {
  final List<DivisionModel> _divisionList = [
    DivisionModel(image: 'images/shwedagon.jpeg', name: 'ရန်ကုန်တိုင်း \n ဒေသကြီး'),
    DivisionModel(image: 'images/division/ngwesaung.jpg', name: 'ဧရာ၀တီတိုင်း \n ဒေသကြီး'),
    DivisionModel(image: 'images/bagan.jpg', name: 'မန္တလေးတိုင်း \n ဒေသကြီး'),
    DivisionModel(image: 'images/division/bago.jpg', name: 'ပဲခူးတိုင်း \n ဒေသကြီး'),
    DivisionModel(image: 'images/division/magwe.jpg', name: 'မကွေးတိုင်း \n ဒေသကြီး'),
    DivisionModel(image: 'images/division/sagaing.jpg', name: 'စစ်ကိုင်းတိုင်း \n ဒေသကြီး'),
    DivisionModel(image: 'images/division/thanintharyi.jpg', name: 'တနင်္သာရီတိုင်း \n ဒေသကြီး'),
    DivisionModel(image: 'images/division/kachin.jpg', name: 'ကချင်ပြည်နယ်'),
    DivisionModel(image: 'images/division/kaya.jpg', name: 'ကယားပြည်နယ်'),
    DivisionModel(image: 'images/division/kayin.jpg', name: 'ကရင်ပြည်နယ်'),
    DivisionModel(image: 'images/division/mon.jpg', name: 'မွန်ပြည်နယ်'),
    DivisionModel(image: 'images/division/rakhine.jpg', name: 'ရခိုင်ပြည်နယ်'),
    DivisionModel(image: 'images/division/shan.jpg', name: 'ရှမ်းပြည်နယ်'),
    DivisionModel(image: 'images/division/chin.jpg', name: 'ချင်းပြည်နယ်'),

  ];

  @override
  Widget build(BuildContext context) {
    double withsize = MediaQuery.of(context).size.width;
    double heighsize = MediaQuery.of(context).size.height;

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
              builder: (context)=>CategoryItem()
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
                          color: Colors.white,),
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
