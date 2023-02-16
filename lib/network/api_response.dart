import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api.dart';


class SearchLocation with ChangeNotifier{

String key = api;
bool _loading = false;
List _locData = [];
List get locData => _locData;
bool get loading => _loading;

void setLoading(bool value){
  _loading = value;
  notifyListeners();
}

Future<void> getLoc(String location) async {
  String uri = 'api.openweathermap.org';
  var locUrl = Uri.https(uri,
    '/geo/1.0/direct',
    {
      'q' : location,
      'limit' : '10',
      'appid' : key
    }
  );
  var locRes = await http.get(locUrl);
  List cords = jsonDecode(locRes.body);
  //debugPrint('$cords');
  _locData = cords;
  debugPrint('$_locData');
  notifyListeners();
}

}

class DateProvider with ChangeNotifier{
  DateTime _date = DateTime.now();
  DateTime get date => _date;

  void dateTime(){
    _date = DateTime.now();
    notifyListeners();
  }

}

class ApiResponse with ChangeNotifier{

  String key = api;
  late double _temp; //temperature of the location
  late int _humidity; // humidity of the location
  late double _airSpeed; // Air Speed of the location
  late String _tempType; // Current Weather type
  late int _aqi; // Air quality Index
  late String _icon; // Icon of the current weather
  late String _country; // name of the country
  late DateTime _date;
  late String _tempDescp;
  late int _timezone;
  late String _city;
  late String _state;
  late int _id;

  double get temp => _temp;
  int get humidity => _humidity;
  double get airSpeed => _airSpeed;
  String get tempType => _tempType;
  int get aqi => _aqi;
  String get icon => _icon;
  String get country => _country;
  String get tempDescp => _tempDescp;
  String get city => _city;
  String get state => _state;
  DateTime get date => _date;
  int get id => _id;


  Future<void> getLocation(String latitude, String longitude) async {
    String uri = 'api.openweathermap.org';
    var locUrl = Uri.https(uri,
        '/data/2.5/weather',
        {
          'lat' : latitude,
          'lon' : longitude,
          'appid' : key,
          'units' : 'metric'
        }
    );
    var response = await http.get(locUrl);
    Map data = jsonDecode(response.body);
    // getting timezone
    _timezone = data['timezone'];

    //getting temp, humidity
    Map mainData = data['main'];
    _temp = mainData['temp'];
    _humidity = mainData['humidity'];

    // getting temp description, icon
    List Weather = data['weather'];
    Map weatherData = Weather[0];
    _tempType = weatherData['main'];
    _tempDescp = weatherData['description'];
    _icon = weatherData['icon'];
    _id = weatherData['id'];

    // getting wind speed
    Map speed = data['wind'];
    _airSpeed = speed['speed'];

    //getting time of the place
    _date = DateTime.now().add(Duration(seconds: _timezone - DateTime.now().timeZoneOffset.inSeconds));

  }


}