import 'dart:async';
import 'package:googleauth/const/stringvalue.dart';
import 'package:googleauth/model/allplaceModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Place {
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
  final String city;
  final String lat;
  final String lon;

  Place(
      {this.placeName,
      this.state,
      this.description,
      this.wonderful,
      this.bestMonth,
      this.location,
      this.map,
      this.recommend,
      this.hostel,
      this.image,
      this.city,
      this.lat,
      this.lon});

  Map<String, dynamic> toMap() {
    return {
      'placeName': placeName,
      'state': state,
      'description': description,
      'wonderful': wonderful,
      'bestMonth': bestMonth,
      'location': location,
      'map': map,
      'recommend': recommend,
      'hostel': hostel,
      'image': image,
      'city': city,
      'lat': lat,
      'lon': lon,
    };
  }

  @override
  String toString() {
    return 'Dog{placeName:$placeName, state: $state, description: $description,wonderful:$wonderful, bestMonth: $bestMonth,location: $location,map:$map recommend:$recommend, hostel:$hostel,image:$image, city:$city, lat:$lat, lon:$lon}';
  }
}

database() async {
  final Future<Database> database =
      openDatabase(join(await getDatabasesPath(), 'place_database1.db'),
          onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE place(placeName TEXT PRIMARY KEY, state TEXT, description TEXT, wonderful TEXT, bestMonth TEXT, location TEXT, map TEXT, recommend TEXT, hostel TEXT, image TEXT, city TEXT, lat TEXT, lon TEXT)");
  }, version: 1);
  return database;
}

Future<void> insertDatabase(Place place) async {
  final Database db = await database();
  await db.insert('place', place.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> updateSelect(String update, String placeName) async {
  final Database db = await database();
  await db.rawUpdate(
      "UPDATE place set recommend=? WHERE placeName=?", [update, placeName]);
}

Future<List<Place>> getStatePlaceDatabase(String place) async {
  final Database db = await database();
  final List<Map<String, dynamic>> maps =
      await db.rawQuery("SELECT * FROM place WHERE state=?", [place]);
  return List.generate(maps.length, (index) {
    return Place(
        placeName: maps[index]['placeName'],
        state: maps[index]['state'],
        description: maps[index]['description'],
        wonderful: maps[index]['wonderful'],
        bestMonth: maps[index]['bestMonth'],
        location: maps[index]['location'],
        map: maps[index]['maps'],
        recommend: maps[index]['recommend'],
        hostel: maps[index]['hostel'],
        image: maps[index]['image'],
        city: maps[index]['city'],
        lat: maps[index]['lat'],
        lon: maps[index]['lon']);
  });
}

Future<List<Place>> getPlaceDetailDatabase(String place) async {
  final Database db = await database();
  final List<Map<String, dynamic>> maps =
      await db.rawQuery("SELECT * FROM place WHERE placeName=?", [place]);
  return List.generate(maps.length, (index) {
    return Place(
        placeName: maps[index]['placeName'],
        state: maps[index]['state'],
        description: maps[index]['description'],
        wonderful: maps[index]['wonderful'],
        bestMonth: maps[index]['bestMonth'],
        location: maps[index]['location'],
        map: maps[index]['maps'],
        recommend: maps[index]['recommend'],
        hostel: maps[index]['hostel'],
        image: maps[index]['image'],
        city: maps[index]['city'],
        lat: maps[index]['lat'],
        lon: maps[index]['lon']);
  });
}

var shweDaogon = [
  Place(
      placeName: 'ရွှေတိဂုံစေတီတော်3',
      state: ygn,
      description: shweDestext,
      wonderful: 'လေးဆူဓာတ်ပုံ မြတ်ရွှေတိဂုံ',
      bestMonth: 'ဒီဇင်ဘာ',
      location: 'သိင်္ဂိုတရကုန်းတော်၊ ဗဟန်းမြို့နယ်၊ ရန်ုကုန်မြို့',
      map: null,
      recommend: 'သွားလည်သင့်သည်။',
      hostel: 'YPP Hostel',
      image: 'images/shwedagon.jpeg',
      city: 'Bahan',
      lat: '10',
      lon: '10'),
  Place(
      placeName: 'ရွှေဆံတော်စေတီတော်',
      state: ygn,
      description: shweSandaw,
      wonderful: 'Good Good',
      bestMonth: 'ဒီဇင်ဘာ',
      location: 'ရွှေဆံတော်ရပ်ကွက်၊ တွံတေးမြို့',
      recommend: 'တွံတေးမြို့ကိုလေ့လာရင်း သဘာ၀အလှတွေနဲ့ပြည့်နေသော နေရာတစ်ခုဖြစ်ပါသည်။',
      hostel: 'YPP Hostel',
      image: 'images/shwedagon.jpeg',
      city: 'Twantay',
      lat: '15',
      lon: '15'),
];
