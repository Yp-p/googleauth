import 'package:flutter/material.dart';
import 'package:googleauth/model/divisionModel.dart';
import 'package:googleauth/page/placeSelect.dart';

class divisionItem extends StatelessWidget {


  // const divisionItem({
  //   Key key,
  //   @required List<DivisionModel> divisionList,
  // }) : _divisionList = divisionList, super(key: key);
  //
  // final List<DivisionModel> _divisionList;
  //
  //
  final List<DivisionModel> _divisionList = [
    DivisionModel(image: 'images/shwedagon.jpeg', name: 'ရန်ကုန်တိုင်းဒေသကြီး'),
    DivisionModel(image: 'images/division/ngwesaung.jpg', name: 'ဧရာဝတီတိုင်းဒေသကြီး'),
    DivisionModel(image: 'images/bagan.jpg', name: 'မန္တလေးတိုင်းဒေသကြီး'),
    DivisionModel(image: 'images/division/bago.jpg', name: 'ပဲခူးတိုင်းဒေသကြီး'),
    DivisionModel(image: 'images/division/magwe.jpg', name: 'မကွေးတိုင်းဒေသကြီး'),
    DivisionModel(image: 'images/division/sagaing.jpg', name: 'စစ်ကိုင်းတိုင်းဒေသကြီး'),
    DivisionModel(image: 'images/division/thanintharyi.jpg', name: 'တနင်္သာရီတိုင်းဒေသကြီး'),
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
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: 1.3),
        itemCount: _divisionList.length,
        itemBuilder: (context, index) {
          DivisionModel divisionModel = _divisionList[index];
          return InkWell(
            onTap: (){
              print(divisionModel.name);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>PlaceSelect(divName: divisionModel.name,)
              ));
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 700,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      divisionModel.image,
                      fit: BoxFit.cover,


                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 100, 0, 0.3),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  margin: EdgeInsets.all(6),
                  height: 700,

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