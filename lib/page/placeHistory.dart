import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlaceHistory extends StatefulWidget {
  final Map data;

  const PlaceHistory({Key key, this.data}) : super(key: key);
  @override
  _PlaceHistoryState createState() => _PlaceHistoryState();
}

class _PlaceHistoryState extends State<PlaceHistory> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                      child: Image.asset('images/shwedagon.jpeg', width: 100,height: 100, fit: BoxFit.cover,)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${widget.data['placeName']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          Text('သမိုင်းအကျဉ်း'),

                        ],
                      ),
                    )
                  ],
                ),

                Divider(thickness: 2,),
                Text('မူရင်းရေးသားသူ = WiKi Myanmar'),
                Text('${widget.data['description']}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
