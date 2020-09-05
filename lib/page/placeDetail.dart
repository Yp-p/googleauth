import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/const/stringvalue.dart';
import 'package:googleauth/database/databaseHelper.dart';

class PlaceDetail extends StatefulWidget {
  final String placeName;

  const PlaceDetail({Key key, this.placeName}) : super(key: key);
  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var place in shweDaogon) {
      insertDatabase(place);

    }
  }
  @override
  Widget build(BuildContext context) {





    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 260),
                child: Column(
                  children: [
                    desCard(),
                    DetailStrangeWidget(),
                    DetailDataWidget(),
                    DetailWeatherWidget(),
                    DetailLocationWidget(),
                    DetailRecommedWidget(),
                    DetailHostelWidget(),

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

                        child: Image.asset(
                          'images/shwedagon.jpeg',
                          height: 250,
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
                                widget.placeName,
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
          ],
        ),
      ),
    );
  }
}
Widget desCard(){
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

    margin: EdgeInsets.all(10),
    // child: shweDestext,
  );
}

class DetailStrangeWidget extends StatelessWidget {
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
                  Icon(Icons.add),
                  Text('ထူးခြားချက်များ'),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('December'),
            )
          ],
        ),
      ),
    );
  }
}


class DetailDataWidget extends StatelessWidget {
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
                  Icon(Icons.add),
                  Text('Best Months to Visit'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('December'),
            )
          ],
        ),
      ),
    );
  }
}

class DetailWeatherWidget extends StatelessWidget {
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
                  Icon(Icons.add),
                  Text('Today Weather Condition'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('16*C'),
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
                  Icon(Icons.add),
                  Text('Location'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('သိဂီတရကုန်းတော်၊ ရန်ကုန်'),
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

class DetailRecommedWidget extends StatelessWidget {
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
                  Icon(Icons.add),
                  Text('Why Should visit this?'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              // child: shweDestext,
            )
          ],
        ),
      ),
    );
  }
}

class DetailHostelWidget extends StatelessWidget {
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
                  Icon(Icons.add),
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
                  Text('Mahar Hostel'),
                  Text('တည်းခိုခ (၁၅၀၀၀) ကျပ်'),
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

