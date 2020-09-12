import 'dart:async';
import 'package:googleauth/const/stringvalue.dart';
import 'package:googleauth/model/allplaceModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Place {
   String placeName;
   final String category;
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
  final num save;

  Place(
      {this.placeName,
        this.category,
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
      this.lon,
      this.save});

  Map<String, dynamic> toMap() {
    return {
      'placeName': placeName,
      'category' : category,
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
      'save': save,
    };
  }

  @override
  String toString() {
    return 'Dog{placeName:$placeName,category:$category, state: $state, description: $description,wonderful:$wonderful, bestMonth: $bestMonth,location: $location,map:$map recommend:$recommend, hostel:$hostel,image:$image, city:$city, lat:$lat, lon:$lon, save:$save}';
  }
}

database() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'place_database1.db'),
    onCreate: (db, version) async{
      await db.execute(
          "CREATE TABLE place(placeName TEXT PRIMARY KEY,category TEXT, state TEXT, description TEXT, wonderful TEXT, bestMonth TEXT, location TEXT, map TEXT, recommend TEXT, hostel TEXT, image TEXT, city TEXT, lat TEXT, lon TEXT, save NUM)");
      for(var data in shweDaogon){
    await db.insert('place', data.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
    },
    version: 1,
  );

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
Future<void> saveUpdate(num save, String placeName) async{
  final Database db= await database();
  await db.rawUpdate("UPDATE place set save=? WHERE placeName=?", [save, placeName]);
}


Future<List<Place>> getStatePlaceDatabase(String place) async {
  final Database db = await database();
  final List<Map<String, dynamic>> maps =
      await db.rawQuery("SELECT * FROM place WHERE state=?", [place]);
  return List.generate(maps.length, (index) {
    return Place(
        placeName: maps[index]['placeName'],
        category: maps[index]['category'],
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
        lon: maps[index]['lon'],
        save: maps[index]['save']);
  });
}

Future<List<Place>> getPlaceDetailDatabase(String place) async {
  final Database db = await database();
  final List<Map<String, dynamic>> maps =
      await db.rawQuery("SELECT * FROM place WHERE placeName=?", [place]);
  return List.generate(maps.length, (index) {
    return Place(
        placeName: maps[index]['placeName'],
        category: maps[index]['category'],
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
        lon: maps[index]['lon'],
        save: maps[index]['save']);
  });
}

Future<List<Place>> getStateSaveDatabase() async {
  final Database db = await database();
  final List<Map<String, dynamic>> maps =
  await db.rawQuery("SELECT * FROM place WHERE save=?", [1]);
  return List.generate(maps.length, (index) {
    return Place(
        placeName: maps[index]['placeName'],
        category: maps[index]['category'],
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
        lon: maps[index]['lon'],
        save: maps[index]['save']);
  });
}


var shweDaogon = [
  Place(
      placeName: 'ရွှေတိဂုံစေတီတော်',
      category: 'ဘုရား',
      state: ygn,
      description: shweDestext,
      wonderful: 'လေးဆူဓာတ်ပုံ မြတ်ရွှေတိဂုံ',
      bestMonth: 'ဒီဇင်ဘာ',
      location: 'သိင်္ဂိုတရကုန်းတော်၊ ဗဟန်းမြို့နယ်၊ ရန်ုကုန်မြို့',
      map: 'https://goo.gl/maps/PDUSE9wpXvqNro7TA',
      recommend: 'အလွန်ကြည်ညိုဖွယ်ကောင်းသော စေတီတစ်ဆူဖြစ်ပါသည်။',
      hostel: 'YPP Hostel',
      image: 'https://lh3.googleusercontent.com/ssb_GyEYf_PghgfraF-5sfZYIy1dAppyvxiTRWGGpNws5bBHZWL99Sp8cqb9wcCXUHzIEmTM8d-n594EPt97uaeV7ZWTYZ3-5chTwXH5jgMs9G6xnPRQKI-ufGEGgm7eDBxMMMG2hv7D--8KnkNKyHDP7CvbI4VIqQDnSurNJtQ04ped9m5uc3HedBam5gwRFJ5NBJtVS5KIM6GRWLvvGG1itb-1-nvzXc9vKxh6knjg6il_w5_P5XUGNS9EZRg6AoXn4zC35uMmQT9z0Dk9t1hnLwzRK5RJcy2bD22kdscqD5Aa286adaWuUOA6_KiOTAVqfGMnOEE4dtg0g0ECopUVFhuQ3alxvDMkZYk5C6rWLrRGnBS_Q79in2E_fmORC0z69NHM-leX3s_Mm6CUX5a1_so30ERYb0rUgIpH-tKyjR5jxwQrxxWpUMODatXtdWi-uHsBnBhic4qUrtbJOzrgCFn58gG8Ye-V1jQp-sAr1-l5jV3QJAV1J1vJdz5UrPKWaxU3bGcWsVM4fb2vmIOfIvoIM9U6sGwHxVm_4DrUUCAyKXNrD3d5hEALCVEfJVzJaqomvr1-A_ngLtYNywJ49je9OHg69zI1WusEXOUyirDC4Q8WtNBb_paDs31tlLp1eGTeInCoaGDOMQCMcp1A7OufgKjEjCT2QSCfig3ITP1zWP5oB5aSlaH_Hw=w640-h426-no?authuser=0',
      city: 'ဗဟန်းမြို့',
      lat: '16.7982337',
      lon: '96.1473617',
      save: 0),
  Place(
      placeName: 'ရွှေဆံတော်စေတီတော်',
      category: 'ဘုရား',
      state: ygn,
      description: shweSandaw,
      wonderful: 'Good Good',
      bestMonth: 'ဒီဇင်ဘာ',
      location: 'ရွှေဆံတော်ရပ်ကွက်၊ တွံတေးမြို့',
      map: 'https://goo.gl/maps/B6iZJQc95rm6chLP9',
      recommend:
          'တွံတေးမြို့ကိုလေ့လာရင်း သဘာ၀အလှတွေနဲ့ပြည့်နေသော နေရာတစ်ခုဖြစ်ပါသည်။',
      // hostel: 'YPP Hostel',
      image: 'https://lh3.googleusercontent.com/OxeVSDvzWLbeZCVWLOYf0ZQ1bXcc8NpD1TuWdO5xYPusWjxviD8JZiSsirBT3SYX00UqPXekK5ZNb4mpvUHwaY62fIhNwlH1W7ujyRa_hlopF3NiANSjCixkxDo0kUwNqZ5OowrMGcY8ABd_IIg4nDID5N_lM_OvWQCdNiXzoI8O1_iqKdNvuNxx9Gpz815gH-gzkZH_Qr7wvzSUMiAD-UwCzqu8-gRuJOtFTw-GPDdvwv0pb8PdTdzJnxo5uIJ5RQsetAD3lZJGXZrLbllh4l5cs9ie6RrcRZDcRky5rmDsqFeloydVTan36bm-kxYkaVLAYwYba94ZZfLk147JoEpjKmY6hfgqZi_1V7eJUHu33LPB_bnfyUOnrNqQfOSzXAxKJams_U8GAqYDKwU4yfVtPQNBJ3gYbu0rul-IRfq7APfyMMbW_vIaYql3Cb1FBK82nwHF1_HVt5MSp7e5FE1fpBl671rhY03Xe5rs6JRAIpC0QDVUwXeYbQip9Yp8uyl3gYc8AoS1Zp8JNK3WtpxwEPwmoFoekMDrhVAZJkHiriT_WkQsUPL75UkX5XF1BzCLs86hPHdY3YBpwNkqKLSVncJ6aHF4B_0Le7lghfF-yEQvJ0UMa6kz2gNjhtsyFgWM2qDY6-XPHBUnrXNxDAxjLLUc1gAfvvenECLkAYwVW_1PA5vGMP577t2kqA=w562-h561-no?authuser=0',
      city: 'တွံတေးမြို့',
      lat: '16.7026697',
      lon: '95.9323399',
      save: 1),
  Place(
      placeName: 'ချောင်းသာကမ်းခြေ',
      category: 'ကမ်းခြေ',
      state: ayawa,
      description: chaungtha,
      wonderful: 'Good Good',
      bestMonth: 'တန်ခူး',
      location: 'ရွှေသောင်ယံမြို့နယ်၊ ချောင်းသာရွာ',
      map: 'https://goo.gl/maps/CvCo2CMrn653GRf39',
      recommend:
      'မြန်မာနိုင်ငံ၏ လူအလည်အပတ်အများဆုံး ကမ်းခြေထဲကတစ်ခုပြီး ပျော်ရွှင်စရာအချိန်တွေဖျက်သန်းချင်ရင် ချောင်းသာသာ လာခဲ့ပါ။',
      hostel: 'DreamLand Motel',
      image: 'https://lh3.googleusercontent.com/lXofWtjhA0ykQtvnySnMZS9BRROb5wAbyG8meVvRSK_3_4FaaASAsh24OqKKCylTXJpOAth6l4QY9G3ANzDOrxlTV48udaGXQJmmYsj0kC8m1wjX2d1jC-l3IbwFWTJop7e9lhEaAQ0EAnxqelBHC3OZ-4nNqUsVwpeYi7Ws-HYn-UTz-o76lhWFoEOdmUs8-04pUUf77UsYeP7Msl7ez7c29AOTlCd2YcaZ0vZrHhu2S4qbsbrf85EpxSZTMkjUMvieJKt8amCyARnfd2zp55DV59tPjILXEd_erXypTaNyEN9qwltNQz92eHV7TZZhT5keG5Brp0nnkVQXnap-w34nlSZaPMmykKDQ4BQnOS8e_sLcwZrRA7sA97KGIMKRYtH8T6ScdX77o69vfXihSgKwhX8t8YKkZO2yZDESFQ8Fexvr_nN1V4T_QkDhfp-X5wC2t6N93jXpkNO7GQCim35uEYRhA3PYZv9N_CFH2F3IIdWjxWrTR-0eBMMKBobe_lhbwpp4tuPcYht2s2W67dNHtje1lOu4NPmrLkqNL83RAL4RNnwDHcmpHg4JxTncGnew3q4Dx3sqAy-EHl_E7ZYOpB6Q123trK_mlfYHREhFMklJ0XholSR08c0hmwh69Nqtwnl0_7Z27xUlhEBnSwpNkl-aXZ6_Z0fqhJ-wCSKd5N_Zr2OBO9U3_EsVBQ=w900-h535-no?authuser=0',
      city: 'ရွှေသောင်ယံမြို့နယ်',
      lat: '16.9571805',
      lon: '94.4304243',
      save: 0)
];
