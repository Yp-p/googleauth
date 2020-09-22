import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/item/divisionItem.dart';
import 'package:googleauth/page/placeDetail.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          body: Column(
            children: [
              // Card(
              //   elevation: 5,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(50),
              //
              //   ),
              //   margin: EdgeInsets.all(10),
              //
              //   child: Container(
              //
              //     width: MediaQuery.of(context).size.width,
              //     margin: EdgeInsets.all(10),
              //
              //
              //     child: Center(
              //       child: SizedBox(
              //
              //       child: ScaleAnimatedTextKit(
              //         totalRepeatCount: 300,
              //         duration: Duration(seconds: 3),
              //       onTap: () {
              //           Navigator.pushNamed(context, '/quiz');
              //       print("Tap Event");
              //       },
              //       text: [
              //
              //       "မြန်မာနိုင်ငံအကြောင်း ဘယ်လောက်သိလဲ...",
              //         "မေးခွန်းလေးတွေဖြေကြည့်ရန်",
              //         "ဒီနေရာကိုနှိပ်ပါ"
              //       ],
              //       textStyle: TextStyle(
              //       fontSize: 17.0,
              //       // color: gColor,
              //       fontFamily: "Bobbers"
              //       ),
              //         isRepeatingAnimation: true,
              //       textAlign: TextAlign.center,
              //       alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              //       ),
              //       ),
              //     ),
              //     // child: ,
              //   ),
              // ),
              Slider(),
              Description()


            ],
          )
    );

  }
}

class Slider extends StatefulWidget {
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  List allResult;

  getAllResult() async{
    CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');

    var data=await users.get();

    setState(() {
      allResult=data.docs;
    });
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/division');
        },
        child: Carousel(
          dotIncreasedColor: gColor,
          images: [
            Image.asset('images/bagan.jpg', fit: BoxFit.cover,),
            Image.asset('images/shwedagon.jpeg',fit: BoxFit.cover,),
            Image.asset('images/division/thanintharyi.jpg',fit: BoxFit.cover,),
            Image.asset('images/division/bago.jpg',fit: BoxFit.cover,),
            Image.asset('images/division/kachin.jpg',fit: BoxFit.cover,),

          ],
        ),
      ),
    );
  }
}

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  Future resultLoad;
  List allResult=[];

  getDocument() async{
    CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');

    var data=await users.get();
    setState(() {
      allResult=data.docs;
    });

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    resultLoad=getDocument();
  }


  @override
  Widget build(BuildContext context) {

      List indexList = new List<int>.generate(allResult.length, (int index) => index); // [0, 1, 4]
      indexList.shuffle();
      print(indexList);

    if(allResult!=null&& allResult.length>0){return Expanded(
      child: RefreshIndicator(
        onRefresh: () async{
          // List indexList = new List<int>.generate(allResult.length, (int index) => index);
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            indexList.shuffle();
          });
          return;
        },
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index){
              Map data=allResult[indexList[index]].data();
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>PlaceDetail(data: data,)
                  ));
                },
                child: Container(

                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: gColor,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text('${data['placeName']}',
                            style:TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold
                            ),),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text('${data['description']}',
                            maxLines: 5,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );}
    return Center(child: CircularProgressIndicator());


  }
}



