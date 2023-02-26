import 'package:flutter/material.dart';
import '../../themes/themes.dart';

appBar(){
  return AppBar(
    title: Text('WeatherPo', style: title(),),
    centerTitle: true,
    backgroundColor: Colors.transparent,
  );
}