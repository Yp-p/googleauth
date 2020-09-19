import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/Service/networking.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/const/stringvalue.dart';
import 'package:googleauth/database/databaseHelper.dart';
import 'package:googleauth/model/Weather/weather.dart';
import 'package:googleauth/page/placeHistory.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetail extends StatefulWidget {
  final data;

  const PlaceDetail({Key key, this.data}) : super(key: key);

  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  double temp = 0;
  String lat;
  String lon;
  Map map = {};
  CollectionReference users = FirebaseFirestore.instance
      .collection('Place')
      .doc('placeData')
      .collection('AllState');

  Map<String, dynamic> weatherData = {};
  List<Place> listData;

  void getDatail() async {
    Future<List> _getList = getPlaceDetailDatabase('ရွှေတိဂုံစေတီတော်3');
    listData = await _getList;

  }

  void getData() async {
    var data = await Service(lat: widget.data['map'].latitude, lon: widget.data['map'].longitude).getData();

    setState(() {
      weatherData = data;
    });
  }

  

  @override
  void initState() {
    super.initState();
    getDatail();
    getData();
  }

  List saveList = [];
  String photoUrl;


  Future downLoadImage() async {

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('placeImage/${widget.data['placeName']}');
    String imageUrl = await storageReference.getDownloadURL();

    setState(() {
      photoUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {



    downLoadImage();
    getPlaceDetailDatabase(widget.data['placeName']).then((value) {
      setState(() {
        saveList = value;
      });
    });


    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: users
            .where('placeName', isEqualTo: widget.data['placeName'])
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          Map dataMap = snapshot.data.docs[0].data();

          if(snapshot.hasData){

          return
            Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    saveList.length != 0
                        ? deleteSaveDatabase(widget.data['placeName'])
                        : insertDatabase(widget.data);
                  });
                },
                child: saveList.length == 0

                    // dataMap['save'] != 1
                    ? Icon(
                        Icons.favorite_border,
                        size: 40,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite,
                        size: 40,
                        color: Colors.red,
                      )),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 220),
                    child: Column(
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>PlaceHistory()
                              ));
                            },
                            child: desCard(dataMap['description'])),
                        DetailWonderfulWidget(
                          dataMap: dataMap,
                        ),
                        DetailMonthsWidget(
                          dataMap: dataMap,
                        ),
                        DetailWeatherWidget(
                          temp: temp != null
                              ? weatherData['temp'].toString()
                              : '0',
                        ),
                        DetailLocationWidget(
                          dataMap: dataMap,
                          map: 'haha',
                        ),
                        DetailRecommedWidget(recommed: dataMap),
                        DetailHostelWidget(
                          hostel: 'YPP Hostel',
                          phone: "hhhh",
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Center(
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            print(temp);
                            print(weatherData['temp']);
                          },
                          child: photoUrl == null
                              ? Image.asset(
                                  'images/bagan.jpg',
                                  height: 200,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                )
                              : Image.network(
                                  photoUrl,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,

                  right: 0,
                  left: 0,

                  // width: MediaQuery.of(context).size.width*,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 175, 20, 0),
                      height: 50,
                      child: Center(
                          child: Text(
                        widget.data['placeName'],
                        style: TextStyle(fontSize: 20),
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );}
          return Text('Your Are note Sign User');
        },
      ),
    );
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

Widget desCard(String description) {
  return InkWell(

    child: Card(

      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      child: Text(
        description != null ? description : '',
        maxLines: 5,
      ),
    ),
  );
}

class DetailWonderfulWidget extends StatelessWidget {
  final Map dataMap;

  const DetailWonderfulWidget({Key key, this.dataMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        print('hhh');
                        showUpdateDialog(context, 'ဘာကြောင့်သွားလည်သင့်လဲ',
                            dataMap['placeName'], dataMap['wonderful'], 'wonderful');
                      },
                      child: Icon(
                        Icons.add_circle,
                      )),
                  Text('ထူးခြားချက်များ'),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(dataMap != null ? dataMap['wonderful'] : ''),
            )
          ],
        ),
      ),
    );
  }
}

class DetailMonthsWidget extends StatelessWidget {
  final Map dataMap;

  const DetailMonthsWidget({Key key, this.dataMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        child: Column(
          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        print('hhh');
                        showUpdateDialog(context, 'ဘာကြောင့်သွားလည်သင့်လဲ',
                            dataMap['placeName'], dataMap['bestMonth'], 'bestMonth');
                      },
                      child: Icon(
                        Icons.add_circle,
                      )),
                  Text('လည်ပတ်ရန် အကောင်းဆုံးလ'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(dataMap == null ? '' : dataMap['bestMonth']),
            )
          ],
        ),
      ),
    );
  }
}

class DetailWeatherWidget extends StatefulWidget {
  final String temp;

  const DetailWeatherWidget({Key key, this.temp}) : super(key: key);

  @override
  _DetailWeatherWidgetState createState() => _DetailWeatherWidgetState();
}

class _DetailWeatherWidgetState extends State<DetailWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        child: Column(
          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Center(child: Text('ယနေ့ ရာသီဉတုအခြေအနေ')),
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
                ))
          ],
        ),
      ),
    );
  }
}

class DetailLocationWidget extends StatelessWidget {
  final Map dataMap;
  final String map;

  const DetailLocationWidget({Key key, this.dataMap, this.map})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _makeLunchApp(String url) async{

      if(await canLaunch(url)){
        launch(url);
      }else{
        throw ('Could not Lauch $url');
      }
    }
    
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        child: Column(
          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        print('hhh');
                        showUpdateDialog(context, 'ဘာကြောင့်သွားလည်သင့်လဲ',
                            dataMap['placeName'], dataMap['location'], 'location');
                      },
                      child: Icon(
                        Icons.add_circle,
                      )),
                  Text('တည်နေရာ'),
                  Icon(
                    Icons.keyboard_arrow_down,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(dataMap != null ? dataMap['location'] : ''),
                  FlatButton(
                    onPressed: (){
                      _makeLunchApp('geo: ${dataMap['map'].latitude},${dataMap['map'].longitude}');
                    },
                    child: Text(
                      'Google Map Location',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
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
  final recommed;

  const DetailRecommedWidget({Key key, this.recommed}) : super(key: key);

  @override
  _DetailRecommedWidgetState createState() => _DetailRecommedWidgetState();
}

class _DetailRecommedWidgetState extends State<DetailRecommedWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        child: Column(
          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        print('hhh');
                        showUpdateDialog(context, 'ဘာကြောင့်သွားလည်သင့်လဲ',
                            widget.recommed['placeName'], widget.recommed['recommend'], 'recommend');
                      },
                      child: Icon(
                        Icons.add_circle,
                      )),
                  Text('ဘာကြောင့်သွားလည်သင့်လဲ'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(widget.recommed['recommend'] != null
                  ? widget.recommed['recommend']
                  : ''),
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

  const DetailHostelWidget({Key key, this.hostel, this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        child: Column(
          children: [
            Container(
              color: Color(0xFFA5D6A7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

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
                  Icon(
                    Icons.map,
                    color: Colors.green,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showUpdateDialog(
    BuildContext context, String label, String placeName, String editTextData, String item) async {
  TextEditingController controller = TextEditingController();
  String editText;

  await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextFormField(
                    initialValue: editTextData,
                onChanged: (value)=>editText=value,


                // controller: controller,
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
                onPressed: () async {
                  CollectionReference users = FirebaseFirestore.instance
                      .collection('Place')
                      .doc('placeData')
                      .collection('AllState');
                 if( editText!=null){
                  users.doc(placeName).update({item: editText});}
                  Navigator.pop(context);
                })
          ],
        );
      });
}
