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
  double _temp = 0; //temperature of the location
   int _humidity = 0; // humidity of the location
  double _airSpeed = 0; // Air Speed of the location
  String _tempType = '-'; // Current Weather type
  int _aqi = 0; // Air quality Index
  String _icon = '-'; // Icon of the current weather
  String _country = '-'; // name of the country
  DateTime _date = DateTime.now();
  String _tempDescp = '-';
  int _timezone = 0;
  String _city = '-';
  String _state = '-';
  int _id = 0;

  double get temp => _temp;
  int get humidity => _humidity;
  int get timezone => _timezone;
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


    //getting city
    _city = data['name'];

    //getting country
    Map sys = data['sys'];
    _country = sys['country'];

    //getting temp, humidity
    Map mainData = data['main'];
    _temp = mainData['temp'];
    _humidity = mainData['humidity'];


    // getting temp description, icon
    List weather = data['weather'];
    Map weatherData = weather[0];
    _tempType = weatherData['main'];
    _tempDescp = weatherData['description'];
    _icon = weatherData['icon'];
    _id = weatherData['id'];


    // getting wind speed
    Map speed = data['wind'];
    _airSpeed = speed['speed'];

    getTime(_timezone);

  }

  void getTime(int timezone) async {
    //getting time of the place
    _date = DateTime.now().add(Duration(seconds: _timezone - DateTime.now().timeZoneOffset.inSeconds));
  }


}