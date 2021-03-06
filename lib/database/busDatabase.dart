import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Bus {
  final int id;
  final String departure;
  final String arrival;
  final int fare;

  Bus({
    this.id,
    this.departure,
    this.arrival,
    this.fare,
  });

  Map<String, dynamic> toMap() {
    return { 'departure': departure, 'arrival': arrival, 'fare': fare};
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Bus{departure: $departure, arrival: $arrival, fare: $fare}';
  }
}

database() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'bus_database0.db'),
    onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE bus(id INTEGER PRIMARY KEY AUTOINCREMENT  ,departure TEXT , arrival TEXT,fare INTEGER)");
      // await db.insert('bus',{'id':5},conflictAlgorithm: ConflictAlgorithm.replace);
      for (var data in busList) {
        await db.insert('bus', data.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    },
    version: 1,
  );
  return database;
}

Future<void> insertDatabase(Map bus) async {
  final Database db = await database();
  await db.insert('bus', bus, conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Bus>> getBusDatabase() async {
  final Database db = await database();
  final List<Map<String, dynamic>> maps = await db.query('bus');
  return List.generate(
      maps.length,
      (index) => Bus(
          id: maps[index]['id'],
          departure: maps[index]['departure'],
          arrival: maps[index]['arrival'],
          fare: maps[index]['fare']));
}

List<Bus> busList = [
  Bus(departure: 'ရန်ကုန်', arrival: 'မအူပင်', fare: 2500),
  Bus(departure: 'ရန်ကုန်', arrival: 'တွံတေး', fare: 1000),
  Bus(departure: 'ရန်ကုန်', arrival: 'ကလော', fare: 12500),
  Bus(departure: 'ရန်ကုန်', arrival: 'အောင်ပန်း', fare: 12500),
  Bus(departure: 'ရန်ကုန်', arrival: 'တောင်ကြီး', fare: 12500),
  Bus(departure: 'ရန်ကုန်', arrival: 'ကောလင်း', fare: 15000),
  Bus(departure: 'မန္တလေး', arrival: 'ကောလင်း', fare: 7000),
  Bus(departure: 'မန္တလေး', arrival: 'နေပြည်တော်', fare: 8000),
  Bus(departure: 'ရန်ကုန်', arrival: 'နေပြည်တော်', fare: 8000),
  Bus(departure: 'ရန်ကုန်', arrival: 'မုံရွာ', fare: 12000),
  Bus(departure: 'ရန်ကုန်', arrival: 'မြင်ခြံ', fare: 11000),
  Bus(departure: 'ရန်ကုန်', arrival: 'မန္တလေး', fare: 13000),
  Bus(departure: 'မန္တလေး', arrival: 'ရန်ကုန်', fare: 13000),
  Bus(departure: 'ရန်ကုန်', arrival: 'မူဆယ်', fare: 26000),
  Bus(departure: 'ရန်ကုန်', arrival: 'လာရှိုး', fare: 16500),
  Bus(departure: 'ရန်ကုန်', arrival: 'မြိတ်', fare: 25000),
  Bus(departure: 'ရန်ကုန်', arrival: 'ပုဂံ', fare: 14000),
  Bus(departure: 'ရန်ကုန်', arrival: 'အင်းလေး', fare: 23000),
  Bus(departure: 'ရန်ကုန်', arrival: 'မြဝတီ', fare: 13000),
  Bus(departure: 'ရန်ကုန်', arrival: 'ပြင်ဦီးလွင်', fare: 12800),
  Bus(departure: 'ရန်ကုန်', arrival: 'မြင်ခြံ', fare: 13000),
  Bus(departure: 'ရန်ကုန်', arrival: 'ပြည်', fare: 7500),
  Bus(departure: 'ရန်ကုန်', arrival: 'ရွှေဘို', fare: 14000),
  Bus(departure: 'ရန်ကုန်', arrival: 'ပဲခူး', fare: 1000),
  //
  //
  //
  //
  //
  //
  //
  // Bus(departure: 'ရန်ကုန်', arrival: 'မင်းလှ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အမ်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အောင်လံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အောင်ပန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အရာတော်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပုဂံ/ညောင်ဦး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပဲခူး', fare: 1000),//
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဗဟင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဗန်းမော်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဘီးလင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဘုတ်ပြင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဘုတလင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ချောက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ချောင်းဦး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ချောင်းဆုံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဒိုက်ဦး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တနိုင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဓနုဖြူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ထားဝယ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဒီမောဆို', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အိန္ဒု', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဂန့်ဂေါ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဂွ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဂွေးကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကြို့ပင်ကောက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဟားခါး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဟဲဟိုး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဟင်္သာတ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဟိုပင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဟိုးပုံး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဖဒို', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဘားအံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဖားကန့်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဖာပွန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဘုရားကြီး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သိန္နီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သီပေါ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ထုံးဘို', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: '၀ှေ့ခါ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အင်းတော်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အင်းလေး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အင်းမ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကညွတ်ကွင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကမ်းဗြူး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကံထူးမ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကိုင်းတော်မ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကုလားပြင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကလော', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကလေး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကမမောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကမ္မ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကံမ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကန့်ဘလူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကန်ပြား', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကန်ပက်လက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကာဘိုး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကာဘိုး-ဇီးကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကသာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကော့ကရိတ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကော့သောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကဇူးကိုင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ခင်ဦး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကုန်းဇောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကူမဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကွတ်ခိုင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျိုက်ခမီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျိုက်လတ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျိုက်ထို', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကြံခင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကြာကန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်ကြီး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်တန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်မဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်ပန်းတောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်ဖြူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်ဆည်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်တံခါး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်တော်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်ရစ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်တော်ရာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျောက်ကျော', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျိန္တလီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျဉ်တောက်ပေါက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျုံဒိုး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျွန်းလှ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ကျွန်းချောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လားရှိုး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လက်ပံလှ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လက်ယက်မ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရပ်စောက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လေးတိုင်စင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လက်ပံတန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လယ်ဝေး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လွိုင်ကော်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လွိုင်လင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'လုံးခင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မအီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မတ္တရာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မကွေး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မလှိုင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မလွန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မန္တလေး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မအူပင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မော်ဟန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မော်လူး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မော်လမြိုင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မိတ္ထီလာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မိကျောင်းရဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မင်းပြား', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မင်းဘူး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မိုးဗြဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မိုးကောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မိုးကုတ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မိုးညှင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မိုင်းပွန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မုံရွာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြောက်ဦး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မုဒုံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မူးကမ်းကြီး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မူးဆယ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြိုင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြန်အောင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြောင်းမြ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြဝတီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြိတ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြင်းကွန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြင်းခြံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြစ်ခြေ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြစ်ကြီးနား', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြစ်သား', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြို့ချောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'မြို့သစ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နမ့်ဖတ်ကာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နမ့်စန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နမ္မတီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နတ်မောက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နွားထိုးကြီး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နတ္တလင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နတ်သံကွင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နောင်ချို', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'နေပြည်တော်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ငပလီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ငါးအိုး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ငါ့သေရာက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ညောင်ကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ညောင်လေးပင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ညောင်ရွှေ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ညောင်တုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အုတ်ဖို', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဉသျှစ်ပင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'အုတ်တွင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပန်းတောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပဒါန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပုတီးကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပခုက္ကူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပလ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပလောက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပုလော', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပုလဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပုသိမ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပေါက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပေါက်တော', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပေါင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပေါင်းတလည်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပေါင်းတည်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပေပင်တိုက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဘုရားငါးဆူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဖယ်ခုံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပဲနွယ်ကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဖားအောက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဖြူး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပင်းဘော', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပင်းတယ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပင်လောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပင်လုံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပုဏ္ဏားကျွန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပုပ္ပါး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပွင့်ဖြူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဖျာပုံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပျော်ဘွယ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပြည်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပြင်ဦးလွင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပြင်စီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပြည်ညောင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ပြွန်တန်ဆာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'စံပါယ်နံသာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆားတောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'စစ်ကိုင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆားမှော်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'စိုင်းကောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'စိုင်ပြင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆိုင်းတောင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'စလင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'စနဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆက်သွား', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'စိတ္ထိန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆပ်သွား', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆော', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆိပ်ဖြူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရွှေကူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရွှေညောင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရွှေစက်တော်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရွှေဘို', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရွှေလှေ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆီမီးခုံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆီဆုံကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆင်ဖြူကျွန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆင်တဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆင်ဖြူရှင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'စစ်တွေ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဆွာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တညောင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဒီပဲယင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တပ်ကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တမူး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တနင်္သာရီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တပ်ကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တောင်တွင်းကြီး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တောင်ကြီး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တောင်ငူ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တောင်သာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တောကျွဲအင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တန့်ဆည်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သမုန်းကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သဖန်းချောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သပြေဝ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သံဖြူဇရပ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သံတွဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သာမည', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သာဝတ်ထိ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သထုံ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သရက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သာစည်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သဲကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သစ်ရာကောက်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ထီးချိုင့်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'သိုက်ချောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ထီးလင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'တောင်ကုတ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဝတ်ထီးကန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဝေါ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဝဲလောင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဝတ်ပုတ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဝမ်းတွင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေနံမ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေနီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရမည်သင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရမ်းဗြဲ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေ့နံ့သာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေဉီး', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေပြာ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေတာရှည်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေနံချောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရေစကြို', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ယင်းမာပင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရွာမွန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ရွာသစ်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဇေယျဝတီ', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဇလွန်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဇရပ်ကွင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဇီးဖြူပင်', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဇီးကုန်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဇီးချောင်း', fare: 10000),
  // Bus(departure: 'ရန်ကုန်', arrival: 'ဇီးကျိုက်', fare: 10000),
  //


];
