import 'package:flutter/material.dart';
import '../../themes/themes.dart';

appBar(Size size){
  return AppBar(
    title: Text('WeatherPo', style: title(size.width*0.09),),
    centerTitle: true,
    backgroundColor: Colors.transparent,
  );
}