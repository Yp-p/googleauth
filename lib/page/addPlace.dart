import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:googleauth/const/stringvalue.dart';


class AddPlace extends StatefulWidget {

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

String dropDownValue=stateList[0];

class _AddPlaceState extends State<AddPlace> {
  String placeName, state, city, desc,wonderful, location, bestMonth, recommend, hostel;

  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('Place').doc('placeData').collection('AllState');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          users.doc(placeName).set(Place(placeName: placeName, state: state,city: city,
          description: desc,wonderful: wonderful, location: location, bestMonth: bestMonth,
          recommend: recommend, hostel: hostel).toMap());

          insertDatabase(Place(placeName: placeName, state: state,
          city: city, description: desc, wonderful: wonderful, location: location,bestMonth: bestMonth,
            recommend: recommend,hostel: hostel
          ));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddPlace()));

        },
        child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      appBar: AppBar(
        title: Text('သင့်၏ အတွေ့အကြုံကို မျှ၀ေလိုက်ပါ', style: TextStyle(fontSize: 14),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.lightGreen,

                )
              ),
              child: TextField(
                onChanged: (value)=>placeName=value,
                textAlign: TextAlign.center,
              decoration: InputDecoration(

                border: InputBorder.none,

                hintText: 'နေရာ၏ နာမည်ရိုက်ထည့်ပါ၊'
              ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child:  DropdownButton(
                underline: Container(),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                value: dropDownValue,
                items: stateList.map((e) => DropdownMenuItem(
                  child: Center(child: Text(e)),
                  value: e,
                )).toList(),

                onChanged: (value){setState(() {
                  dropDownValue=value;
                });},

              ),
            ),

            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child: TextField(
                onChanged: (value)=>city=value,
                textAlign: TextAlign.center,

                decoration: InputDecoration(

                    border: InputBorder.none,

                    hintText: 'မြို့နာမည်'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child: TextField(
                onChanged: (value)=>desc=value,
                textAlign: TextAlign.center,
                minLines: 6,
                maxLines: 15,
                decoration: InputDecoration(

                    border: InputBorder.none,

                    hintText: 'နေရာ၏ သမိုင်းကြောင်း (သို့) အကြောင်းအရာ'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child: TextField(
                onChanged: (value)=>wonderful=value,
                minLines: 5,
                maxLines: 15,
                textAlign: TextAlign.center,
                decoration: InputDecoration(

                    border: InputBorder.none,


                    hintText: 'ထူးခြားချက်များ'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child: TextField(
                onChanged: (value)=>location=value,
                maxLines: 5,
                minLines: 3,
                textAlign: TextAlign.center,
                decoration: InputDecoration(

                    border: InputBorder.none,

                    hintText: 'တည်နေရာ'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child: TextField(
                onChanged: (value)=>bestMonth=value,
                textAlign: TextAlign.center,
                decoration: InputDecoration(

                    border: InputBorder.none,

                    hintText: 'လည်ပတ်ရန် အကောင်းဆုံးလ'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child: TextField(
                onChanged: (value)=>recommend=value,
                minLines: 3,
                maxLines: 5,
                textAlign: TextAlign.center,
                decoration: InputDecoration(

                    border: InputBorder.none,

                    hintText: 'ဘာကြောင့်သွားလည်သင့်လဲ'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child: TextField(
                maxLines: 5,
                minLines: 3,
                textAlign: TextAlign.center,
                decoration: InputDecoration(

                    border: InputBorder.none,

                    hintText: 'အနီးအနားတည်းခိုရန်နေရာ'
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
