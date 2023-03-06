import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'api.dart';
import 'aqi.dart';


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
  try{
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
  }catch(e){
    debugPrint('$e');
  }

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
  double _maxTemp = 0;
  double _minTemp = 0;
  String _tempDescp = '-';
  int _timezone = 0;
  String _city = '-';
  int _id = 0;
  double _o3 = 0;
  double _pm25 = 0;
  double _co = 0;
  String _aqiDesc = '';


  double get maxTemp => _maxTemp;
  double get minTemp => _minTemp;
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
  int get id => _id;
  String get aqiDesc => _aqiDesc;


  Future<void> getLocation(String latitude, String longitude) async {
    try{
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

    //getting temp, humidity,max,min
    Map mainData = data['main'];
    _temp = mainData['temp'];
    _humidity = mainData['humidity'];
    _minTemp = mainData['temp_min'];
    _maxTemp = mainData['temp_max'];


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

    //getting aqi
    var aqiUrl = Uri.https(uri,
    '/data/2.5/air_pollution',
    {
    'lat' : latitude,
    'lon' : longitude,
    'appid' : key,
    });
    var aqiRes = await http.get(aqiUrl);

    Map mainAqiData = jsonDecode(aqiRes.body);
    List innerData = mainAqiData['list'];
    Map lists = innerData[0];
    Map components = lists['components'];
    _o3 = components['o3'];
    _pm25 = components['pm2_5'];
    _co = components['co'];
    _o3 = _o3*0.00051;
    _co = _co*0.000873;

    _aqi = getAqi(_o3, _pm25, _co);
    _aqiDesc = getAqiDesc(_aqi);


    }catch(e){
      debugPrint('$e');
    }

  }

}

class DateProvider with ChangeNotifier{

  DateTime _date = DateTime.now();
  int _timezone = 0;

  int get timezone => _timezone;
  DateTime get date => _date;

  void getTime(int timezone) async {
    //debugPrint('$timezone');
    _timezone = timezone;
    //getting time of the place
     _date = DateTime.now().add(Duration(seconds: _timezone - DateTime.now().timeZoneOffset.inSeconds));
    //_date = DateFormat.yMMMd().add_jm().format(_Date);
    notifyListeners();
  }
}