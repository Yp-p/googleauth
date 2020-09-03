import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/const/stringvalue.dart';

class PlaceDetail extends StatefulWidget {
  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
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

                    DetailDataWidget(),
                    DetailDataWidget(),
                    DetailDataWidget(),
                    DetailDataWidget(),
                    DetailDataWidget(),
                    DetailDataWidget(),
                    DetailDataWidget(),
                    DetailDataWidget(),
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
                      child: Image.asset(
                        'images/shwedagon.jpeg',
                        height: 250,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
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
                                'ရွှေတိဂုံစေတီတော်',
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

class DetailDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
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
              height: 50,
              child: Text('December'),
            )
          ],
        ),
      ),
    );
  }
}

