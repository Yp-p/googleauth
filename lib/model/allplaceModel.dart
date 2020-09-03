
import 'package:googleauth/model/placemodel.dart';
import 'package:googleauth/page/placeSelect.dart';
  List<PlaceModel> yangon = [
    PlaceModel(image: 'images/shwedagon.jpeg', name: 'shweDagon'),
    PlaceModel(image: 'images/shwedagon.jpeg', name: 'shweDagon')
  ];
  List<PlaceModel> aya = [
    PlaceModel(image: 'images/division/ngwesaung.jpg', name: 'ngewsaung'),
    PlaceModel(image: 'images/division/ngwesaung.jpg', name: 'ngwesaung')
  ];


  Map<String, List<PlaceModel>> map = {
    'ရန်ကုန်တိုင်းဒေသကြီး': yangon,
    'ဧရာ၀တီတိုင်းဒေသကြီး': aya,

  };