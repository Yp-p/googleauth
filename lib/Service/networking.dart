import 'package:googleauth/model/Weather/weather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class Service{
  final double lat;
  final double lon;

  Service({this.lat, this.lon});
 Future getData() async{
   String apikey='5423563ddaa6ddcc41a6b99853ef188e';
  var url='http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apikey&units=metric';

  Map<String, dynamic> weather={};
  http.Response response= await http.get(url);

  if (response.statusCode == 200) {
    var decodeData= convert.jsonDecode(response.body);
    // double temperature=decodeData['main']['temp'];
    return decodeData['main'];
    // return weather;
  } else {
    print('$response.statusCode');
    return List<Weather>();
  }

}
}
