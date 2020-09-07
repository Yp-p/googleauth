import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/database/databaseHelper.dart';

class AddPlace extends StatelessWidget {

  String placeName, state, city, desc,wonderful, location, bestMonth, recommend, hostel;




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

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
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.lightGreen,

                  )
              ),
              child: TextField(
                onChanged: (value)=>state=value,
                textAlign: TextAlign.center,

                decoration: InputDecoration(

                    border: InputBorder.none,

                    hintText: 'တိုင်းဒေသကြီး (သို့) ပြည်နယ်ထည့်ပါ'
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