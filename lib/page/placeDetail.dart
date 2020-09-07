import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/Service/networking.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/const/stringvalue.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:googleauth/model/Weather/weather.dart';

class PlaceDetail extends StatefulWidget {
  final placeName;

  const PlaceDetail({Key key, this.placeName}) : super(key: key);
  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  double temp=0;
  String lat;
  String lon;

  Map<String,dynamic> weatherData={};

  void getData() async{
    var data= await Service(lat: widget.placeName.lat, lon: widget.placeName.lon).getData();
    setState(() {
      weatherData=data;
      temp=weatherData['temp'];


    });

  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {




    return SafeArea(
      child: Scaffold(
        body:
        // FutureBuilder(
        //   future: widget.placeName,
        //   builder: (BuildContext context, AsyncSnapshot snapshot){
        //     lat='10';
        //     lon='10';
        //
        //     if(snapshot.hasData){ return
              Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 220),
                  child: Column(
                    children: [
                      desCard(widget.placeName.description),
                      DetailWonderfulWidget(wonderful: widget.placeName.wonderful,),
                      DetailMonthsWidget(months: widget.placeName.bestMonth,),
                      DetailWeatherWidget (temp: temp!=null?temp:0,),
                      DetailLocationWidget(address: widget.placeName.location, map: 'haha',),
                      DetailRecommedWidget(recommed: widget.placeName),
                      DetailHostelWidget(hostel: 'YPP Hostel', phone: "hhhh",),

                    ],
                  ),
                ),
              ),

              Positioned(
                top: 0,
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: InkWell(
                            onTap: (){print(temp);
                            print(weatherData['temp']);},
                          child: Image.asset(
                            widget.placeName.image==null?'images/bagan.jpg':widget.placeName.image,
                            height: 200,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        child: Center(
                          child: Container(
                            margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            height: 50,
                            child: Center(
                                child: Text(
                                  widget.placeName.placeName,
                                  style: TextStyle(fontSize: 20),
                                )),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFA5D6A7),),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],),),);
          // );
      //     }else{
      //       return CircularProgressIndicator();}
      //     }
      //
      //   ),
      // ),
    // );
  }
}
Widget desCard(String description){
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

    margin: EdgeInsets.all(10),
    child: Text(description, maxLines: 5,),
  );
}

class DetailWonderfulWidget extends StatelessWidget {
  final String wonderful;

  const DetailWonderfulWidget({Key key, this.wonderful}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
      child: Container(
        child: Column(

          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add_circle),
                  Text('ထူးခြားချက်များ'),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(wonderful!=null? wonderful : ''),
            )
          ],
        ),
      ),
    );
  }
}


class DetailMonthsWidget extends StatelessWidget {
  final String months;

  const DetailMonthsWidget({Key key, this.months}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
      child: Container(
        child: Column(

          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add_circle),
                  Text('လည်ပတ်ရန် အကောင်းဆုံးလ'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(months==null?'':months),
            )
          ],
        ),
      ),
    );
  }
}

class DetailWeatherWidget extends StatefulWidget {
  final double temp;

  const DetailWeatherWidget({Key key, this.temp}) : super(key: key);

  @override
  _DetailWeatherWidgetState createState() => _DetailWeatherWidgetState();
}

class _DetailWeatherWidgetState extends State<DetailWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
      child: Container(
        child: Column(

          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add_circle),
                  Text('ယနေ့ ရာသီဉတုအခြေအနေ'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('${widget.temp} °C  ☔'),
                  Icon(Icons.ac_unit),
                  Expanded(

                    child: Column(
                      children: [
                        Text('Weather is Cold'),
                        Text('Should bring Warm Coat')
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

class DetailLocationWidget extends StatelessWidget {
  final String address;
  final String map;

  const DetailLocationWidget({Key key, this.address, this.map}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
      child: Container(
        child: Column(

          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add_circle,),
                  Text('တည်နေရာ'),
                  Icon(Icons.keyboard_arrow_down,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(address!=null? address : ''),
                  Text('Google Map Location', style: TextStyle(color: Colors.blue),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailRecommedWidget extends StatefulWidget {
  final  recommed;

  const DetailRecommedWidget({Key key, this.recommed}) : super(key: key);

  @override
  _DetailRecommedWidgetState createState() => _DetailRecommedWidgetState();
}

class _DetailRecommedWidgetState extends State<DetailRecommedWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
      child: Container(
        child: Column(

          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){print('hhh');
                      showUpdateDialog(context, 'ဘာကြောင့်သွားလည်သင့်လဲ', widget.recommed.placeName);},
                      child: Icon(Icons.add_circle,)),
                  Text('ဘာကြောင့်သွားလည်သင့်လဲ'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(widget.recommed.recommend),
            )
          ],
        ),
      ),
    );
  }
}

class DetailHostelWidget extends StatelessWidget {
  final String hostel;
  final String phone;

  const DetailHostelWidget({Key key, this.hostel, this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10,right: 10, bottom: 10),
      child: Container(
        child: Column(

          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add_circle),
                  Text('အနီးအနား တည်ခိုးရန်နေရာ'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(hostel),
                  Text(phone),
                  Icon(Icons.map, color: Colors.green,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


void showUpdateDialog(BuildContext context, String label,String placeName) async{
  TextEditingController controller= TextEditingController();
  await showDialog<String>(
      context: context,
  builder: (BuildContext context){
        return AlertDialog(
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    controller: controller,

                    // controller: controller,
                    minLines: 5,
                    maxLines: 10,
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: label,
                    ),
                  ))
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);

                }),
            new FlatButton(
                child: const Text('Save'),
                onPressed: () async{

                await updateSelect(controller.value.text, placeName);
                Navigator.pop(context);
                })
          ],
        );
  });

}



