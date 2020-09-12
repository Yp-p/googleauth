import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/authentication/anthentication.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/screen/logInPage.dart';
import 'package:googleauth/screen/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  BaseAuth baseAuth;
  TextEditingController a = TextEditingController();
  QuerySnapshot querySnapshot;

  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      print(auth.currentUser.email);
    }

    FirebaseFirestore.instance
        .collection('UserInfo').doc('UserID').collection('UserData')
        .where('email', isEqualTo: 'yanpaingphyoeypp@gmail.com')
        .get()
        .then((value) {
    print(value);
      querySnapshot=value;
        print(querySnapshot);}
    );
    print('ypp $querySnapshot');



  }

  @override
  Widget build(BuildContext context) {
    var userinfo=FirebaseFirestore.instance
        .collection('UserInfo').doc('UserID').collection('UserData')
        .where('email', isEqualTo: '${auth.currentUser.email}');

    return Scaffold(
      floatingActionButton: Container(
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          color: Colors.lightGreen.shade300,
          onPressed: () {},
          child: Text(
            "အချက်အလက်ပြင်ဆင်ရန်",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: userinfo.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
          Map data=snapshot.data.docs[0].data();
          return userinfoItem(data: data,);
            // Text('${data['phone']}  ${auth.currentUser.email}' );
        },
      ),
    );
  }
}

class userinfoItem extends StatelessWidget {
  final Map data;

  const userinfoItem({Key key, this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                '${data['userName']}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '${data['email']}',
                style: TextStyle(fontSize: 13),
              ),
              Text('အသုံးပြုသူအချက်အလက်'),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text('${data['city']}'),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.phone_in_talk),
                title: Text('${data['phone']}'),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  '${data['email']}',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                  leading: Icon(Icons.kitchen), title: Text('${data['city']}')),
              RaisedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                              child: Text(
                            'အကောင့်မှ ထွက်မည်လား။',
                            style: TextStyle(fontSize: 15),
                          )),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('မထွက်သေးပါ'),
                            ),
                            FlatButton(
                              onPressed: () {

                                signout().whenComplete(() =>
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RootPage()))
                                );

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
    );
  }
}
