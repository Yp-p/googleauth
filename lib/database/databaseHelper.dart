import 'dart:async';
import 'package:googleauth/const/stringvalue.dart';
import 'package:googleauth/model/allplaceModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class Place{
  final String placeName;
  final String state;
  final String description;
  final String wonderful;
  final String bestMonth;
  final String location;
  final String map;
  final String recommend;
  final String hostel;
  final String image;

  Place({this.placeName,this.state, this.description, this.wonderful,
  this.bestMonth, this.location, this.map, this.recommend, this.hostel, this.image});
  Map<String, dynamic> toMap(){
    return {
      'placeName': placeName,
      'state':state,
    'description': description,
    'wonderful' :wonderful,
    'bestMonth' : bestMonth,
    'location' : location,
    'map': map,
    'recommend' :recommend,
    'hostel':hostel,
      'image':image
    };

    }

  @override
  String toString() {
    return 'Dog{placeName:$placeName, state: $state, description: $description,wonderful:$wonderful, bestMonth: $bestMonth,location: $location, recommend:$recommend, hostel:$hostel,image:$image}';
  }

}

 database() async{
  final Future<Database> database=openDatabase(
    join(await getDatabasesPath(), 'place_database.db'),
    onCreate: (db, version){
      return db.execute(
        "CREATE TABLE place(placeName TEXT PRIMARY KEY, state TEXT, description TEXT, wonderful TEXT, bestMonth TEXT, location TEXT, map TEXT, recommend TEXT, hostel TEXT, image TEXT)"
      );
    },
    version: 1
  );
  return database;
 }

 Future<void> insertDatabase(Place place) async{
  final Database db= await database();
  await db.insert('place', place.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
 }

 Future<List<Place>> getStatePlaceDatabase(String place) async{
  final Database db=await database();
  final List<Map<String, dynamic>> maps= await db.rawQuery("SELECT * FROM place WHERE state=?",[place]);
  return List.generate(maps.length, (index) {
    return Place(
      placeName: maps[index]['placeName'],
      state: maps[index]['state'],
      description: maps[index]['description'],
      wonderful: maps[index]['wonderful'],
      bestMonth: maps[index]['bestMonth'],
      location: maps[index]['location'],
      recommend: maps[index]['recommend'],
      hostel: maps[index]['hostel'],
        image: maps[index]['image']
    );
  });

 }



 var shweDaogon=[Place(
   placeName: 'ရွှေတိဂုံစေတီတော်1',
   state: ygn,
   description: shweDestext,
   wonderful: null,
   bestMonth: 'ဒီဇင်ဘာ',
   location: null,
   recommend: 'သွားလည်သင့်သည်။',
     hostel: 'YPP Hostel',
   image: 'images/shwedagon.jpeg'
 ),

Place(
    placeName: 'ရွှေဆံတော်',
    state: 'မွန်ပြည်နယ်',
    description: shweDestext,
    wonderful: null,
    bestMonth: 'ဒီဇင်ဘာ',
    location: null,
    recommend: 'သွားလည်သင့်သည်။',
    hostel: 'YPP Hostel',
    image: 'images/shwedagon.jpeg'
)
 ];



