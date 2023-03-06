
import 'dart:math';

import 'package:flutter/cupertino.dart';

getAqi(var o3, var pm25,var co){
  debugPrint('$o3, $pm25, $co');
  double aqiv = 0;
  int IHi;
  int Ilo;
  int BPHi;
  num BPlo;
  double Cp;
  double o3Index;
  double pm25Index;
  double coIndex;

  if (o3>=0 && o3<=50)
  {
    IHi=50;
    Ilo=0;
    BPHi=50;
    BPlo=0;
    Cp=o3;
    o3Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(o3>=51 && o3<=100)
  {
    IHi=100;
    Ilo=51;
    BPHi=100;
    BPlo=51;
    Cp=o3;
    o3Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(o3>=101 && o3<=168)
  {
    IHi=200;
    Ilo=101;
    BPHi=168;
    BPlo=101;
    Cp=o3;
    o3Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(o3>=169 && o3<=208)
  {
    IHi=300;
    Ilo=201;
    BPHi=208;
    BPlo=169;
    Cp=o3;
    o3Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(o3>=209 && o3<=748)
  {
    IHi=400;
    Ilo=301;
    BPHi=748;
    BPlo=209;
    Cp=o3;
    o3Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else
  {
    IHi=500;
    Ilo=401;
    BPHi=1000;
    BPlo=748;
    Cp=o3;
    o3Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  aqiv = max(aqiv, o3Index);

  // Particulate matter (PM2.5) calculation

  if(pm25>=0 && pm25<=30)
  {
    IHi=50;
    Ilo=0;
    BPHi=30;
    BPlo=0;
    Cp=pm25;
    pm25Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(pm25>=31 && pm25<=60)
  {
    IHi=100;
    Ilo=51;
    BPHi=60;
    BPlo=31;
    Cp=pm25;
    pm25Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(pm25>=61 && pm25<=90)
  {
    IHi=200;
    Ilo=101;
    BPHi=90;
    BPlo=61;
    Cp=pm25;
    pm25Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(pm25>=91 && pm25<=120)
  {
    IHi=300;
    Ilo=201;
    BPHi=120;
    BPlo=91;
    Cp=pm25;
    pm25Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(pm25>=121 && pm25<=250)
  {
    IHi=400;
    Ilo=301;
    BPHi=250;
    BPlo=121;
    Cp=pm25;
    pm25Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else
  {
    IHi=500;
    Ilo=401;
    BPHi=379;
    BPlo=250;
    Cp=pm25;
    pm25Index= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  aqiv = max(aqiv, pm25Index);

  // Carbon monoxide (CO) calculation

  if(co>=0 && co<=1)
  {
    IHi=50;
    Ilo=0;
    BPHi=1;
    BPlo=0;
    Cp=co;
    coIndex= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(co>=1.1 && co<=2)
  {
    IHi=100;
    Ilo=51;
    BPHi=2;
    BPlo=1.1;
    Cp=co;
    coIndex= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(co>=2.1 && co<=10)
  {
    IHi=200;
    Ilo=101;
    BPHi=10;
    BPlo=2.1;
    Cp=co;
    coIndex= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(co>=10.1 && co<=17)
  {
    IHi=300;
    Ilo=201;
    BPHi=17;
    BPlo=10.1;
    Cp=co;
    coIndex= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else if(co>=17.1 && co<=34)
  {
    IHi=400;
    Ilo=301;
    BPHi=34;
    BPlo=17.1;
    Cp=co;
    coIndex= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  else
  {
    IHi=500;
    Ilo=401;
    BPHi=69;
    BPlo=34.1;
    Cp=co;
    coIndex= (((IHi - Ilo) / (BPHi - BPlo)) * (Cp - BPlo)) + Ilo;
  }
  aqiv = max(aqiv, coIndex);

  return aqiv.toInt();
}

getAqiDesc(int aqi){
  if( aqi >= 0 && aqi <= 50){
    return 'Very Good';
  }
  else if( aqi >= 51 && aqi <=100){
    return 'Good';
  }
  else if(aqi >= 101 && aqi <= 200){
    return 'Moderate';
  }
  else if(aqi >= 201 && aqi <= 300){
    return 'Poor';
  }
  else if(aqi >= 301 && aqi <= 400){
    return 'Very Poor';
  }
  else if(aqi >= 401){
    return 'Severe';
  }
  else{
    return 'N/A';
  }
}