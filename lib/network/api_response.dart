import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';
import 'api.dart';


class ApiResponse with ChangeNotifier{

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
  debugPrint('$cords');
  _locData = cords;
  notifyListeners();
}
}