import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:weather_app_provider/constants.dart';

loadInterstitialAd(){
  UnityAds.load(
    placementId: loadingAdId,
    onComplete: (placementId) => debugPrint('Load Complete $placementId'),
    onFailed: (placementId, error, message) => debugPrint('Load Failed $placementId: $error $message'),
  );
}

showAdVideo() async {
  await UnityAds.showVideoAd(
    placementId: loadingAdId,
    onStart: (placementId) => debugPrint('Video Ad $placementId started'),
    onClick: (placementId) => debugPrint('Video Ad $placementId click'),
    onSkipped: (placementId) => debugPrint('Video Ad $placementId skipped'),
    onComplete: (placementId) => debugPrint('Video Ad $placementId completed'),
    onFailed: (placementId, error, message) => debugPrint('Video Ad $placementId failed: $error $message'),
  );
}
