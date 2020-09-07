import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/authentication/anthentication.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/screen/logInPage.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  BaseAuth baseAuth;
  TextEditingController a= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          color: Colors.lightGreen.shade300,
          onPressed: (){},
          child: Text("အချက်အလက်ပြင်ဆင်ရန်", style: TextStyle(color: Colors.white),),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
                children: [
                  Text('Yan Paing Phyoe', style: TextStyle(fontSize: 20),),
                  Text('yanpaingphyoeypp@gmail.com',style: TextStyle(fontSize: 13),),

                  Text('အသုံးပြုသူအချက်အလက်'),
                  Divider(thickness: 2,),
                  ListTile(
                  leading: Icon(Icons.location_city),
                    title: Text('တွံတေးမြို့'),),
                  Divider(thickness: 2,),
                  ListTile(
                    leading: Icon(Icons.phone_in_talk),
                    title: Text('+959454440086'),),
                  Divider(thickness: 2,),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('yanpaingphyoeypp@gmail.com', style: TextStyle(fontSize: 14),),),
                  Divider(thickness: 2,),
                  ListTile(
                    leading: Icon(Icons.kitchen),
                    title: Text('တွံတေးမြို့')),
                  RaisedButton(
                    onPressed: (){
                      showDialog(context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Center(child: Text('အကောင့်မှ ထွက်မည်လား။', style: TextStyle(fontSize: 15),)),
                          actions: [

                            FlatButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('မထွက်သေးပါ'),
                            ),
                            FlatButton(
                              onPressed: (){
                                signout();
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=> LogInPage()
                                ));
                              },
                              child: Text('ထွက်ပါမည်'),
                            )
                          ],
                        );
                      });
                      // signout();
                      // Navigator.push(context, MaterialPageRoute(builder:
                      // (context)=>LogInPage()));

                    },
                    child: Text('အကောင့်မှ ထွက်ရန်'),
                    color: Colors.green.shade200,
                  ),



                ],
              ),
          ),
        ),
      ),
    );
  }
}
