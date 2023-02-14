import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'api.dart';


class ApiResponse{

String key = api;

Future<void> getLoc(String location) async {
  String uri = 'https://api.openweathermap.org';
  var LocUrl = Uri.https(uri,
    '/geo/1.0/direct',
    {
      'q' : location,
      'appid' : key
    }
  );
  var LocRes = await http.get(LocUrl);
  List Cords = jsonDecode(LocRes.body);
}
}