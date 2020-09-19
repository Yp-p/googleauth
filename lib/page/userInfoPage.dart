import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/authentication/anthentication.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/screen/logInPage.dart';
import 'package:googleauth/screen/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  BaseAuth baseAuth;
  TextEditingController a = TextEditingController();
  QuerySnapshot querySnapshot;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      print('${auth.currentUser}');
    }

    FirebaseFirestore.instance
        .collection('UserInfo')
        .doc('UserID')
        .collection('UserData')
        .where('email', isEqualTo: 'yanpaingphyoeypp@gmail.com')
        .get()
        .then((value) {
      print(value);
      querySnapshot = value;
      print(querySnapshot);
    });
    print('ypp $querySnapshot');
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    if (firebaseAuth.currentUser != null) {
      DocumentReference usersInfo = FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(firebaseAuth.currentUser.email);

      return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
          stream: usersInfo.snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              return userinfoItem(
                data: snapshot.data.data(),
              );
            }
            return Center(child: CircularProgressIndicator());
            // Text('${data['phone']}  ${auth.currentUser.email}' );
          },
        ),
      );
    } else {

      // No login User
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Log In မဝင်ထားသည့်အတွက် \n အချက်အလက်များ မရရှိနိုင်ပါ။',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: gColor),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade400,
                border: Border.all(
                  color: gColor,)
                ),

                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RootPage()));
                    FirebaseAuth.instance.authStateChanges();
                  },
                  child: Text(
                    'Log In ဝင်ရန်',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class userinfoItem extends StatefulWidget {
  final data;

  const userinfoItem({Key key, this.data}) : super(key: key);

  @override
  _userinfoItemState createState() => _userinfoItemState();
}

class _userinfoItemState extends State<userinfoItem> {
  File image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickFile.path);
    });
  }

  Future uploadPic(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String fileName = basename(image.path);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('UserProfile/${firebaseAuth.currentUser.email}');
    print(storageReference.getDownloadURL());
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Uploaded'),
      ));
      print('complete');
    });
  }

  String photoUrl;

  Future downLoadUserPhoto() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('UserProfile/${firebaseAuth.currentUser.email}');
    String downAddress = await storageReference.getDownloadURL();
    setState(() {
      photoUrl = downAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    String textField;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    DocumentReference updateInfo = FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(firebaseAuth.currentUser.email);

    downLoadUserPhoto();
    // firebaseAuth.currentUser.updateProfile(displayName: null);

    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  child: InkWell(
                      onTap: getImage,
                      child: photoUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                photoUrl,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : Image.asset('images/division/shan.jpg'))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${firebaseAuth.currentUser.displayName}',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('အသုံးပြုသူ အမည် '),
                              content: TextFormField(
                                // controller: controller,
                                onChanged: (value) => textField = value,
                                initialValue:
                                    firebaseAuth.currentUser.displayName != null
                                        ? firebaseAuth.currentUser.displayName
                                        : '',
                                autofocus: true,
                              ),
                              actions: [
                                FlatButton(
                                  child: Text('အတည်ပြုသည်'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    if (textField != null) {
                                      firebaseAuth.currentUser.updateProfile(
                                          displayName: textField);
                                    }
                                  },
                                )
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.add_to_photos),
                  )
                ],
              ),
              Text(
                '${firebaseAuth.currentUser.email}',
                style: TextStyle(fontSize: 13),
              ),
              Text('အသုံးပြုသူအချက်အလက်'),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: widget.data['city'] != null
                    ? Text('${widget.data['city']}')
                    : Text('အချက်အလက်မရှိသေးပါ'),
                trailing: InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'နေထိုင်သောမြို့',
                                style: TextStyle(fontSize: 15),
                              ),
                              content: TextFormField(
                                // controller: controller,
                                onChanged: (value) => textField = value,
                                initialValue: widget.data != null &&
                                        widget.data['city'] != null
                                    ? widget.data['city']
                                    : '',
                                autofocus: true,
                              ),
                              actions: [
                                FlatButton(
                                  child: Text('အတည်ပြုသည်'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    if (textField != null) {
                                      updateInfo.update({'city': textField});
                                    }
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Icon(Icons.note_add)),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.phone_in_talk),
                title: widget.data['phone'] != null
                    ? Text('${widget.data['phone']}')
                    : Text('အချက်အလက်မရှိသေးပါ'),
                trailing: InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'ဖုန်နံပါတ်',
                                style: TextStyle(fontSize: 15),
                              ),
                              content: TextFormField(
                                onChanged: (value) => textField = value,
                                initialValue: widget.data != null
                                    ? widget.data['phone']
                                    : '',
                                autofocus: true,
                              ),
                              actions: [
                                FlatButton(
                                  child: Text('အတည်ပြုသည်'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    if (textField != null) {
                                      updateInfo.update({'phone': textField});
                                    }
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Icon(Icons.note_add)),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.supervisor_account),
                title: widget.data['gender'] != null
                    ? Text('${widget.data['gender']}')
                    : Text('အချက်အလက်မရှိသေးပါ'),
                trailing: InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'အမျိုးသား/အမျိုးသမီး',
                                style: TextStyle(fontSize: 15),
                              ),
                              content: TextFormField(
                                onChanged: (value) => textField = value,
                                initialValue: widget.data != null
                                    ? widget.data['gender']
                                    : '',
                                autofocus: true,
                              ),
                              actions: [
                                FlatButton(
                                  child: Text('အတည်ပြုသည်'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    if (textField != null) {
                                      updateInfo.update({'gender': textField});
                                    }
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Icon(Icons.note_add)),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: widget.data['age'] != null
                    ? Text('${widget.data['age']}')
                    : Text('အချက်အလက်မရှိသေးပါ'),
                trailing: InkWell(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'အသက်',
                                style: TextStyle(fontSize: 15),
                              ),
                              content: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) => textField = value,
                                initialValue: widget.data != null
                                    ? widget.data['age']
                                    : '',
                                autofocus: true,
                              ),
                              actions: [
                                FlatButton(
                                  child: Text('အတည်ပြုသည်'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    if (textField != null) {
                                      updateInfo.update({'age': textField});
                                    }
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Icon(Icons.note_add)),
              ),
              RaisedButton(
                onPressed: () {
                  uploadPic(context);
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
                                signout();
                                FirebaseAuth.instance
                                    .authStateChanges()
                                    .listen((User user) {
                                  if (user == null) {
                                    print('User is currently signed out!');
                                  } else {
                                    print('User is signed in!');
                                  }
                                  Navigator.pop(context);
                                });
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
