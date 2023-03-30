import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:weather_app_provider/constants.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/screens/components/interstitial_ad.dart';
import 'package:weather_app_provider/screens/screen_sizes/large.dart';
import 'package:weather_app_provider/screens/screen_sizes/medium.dart';
import 'package:weather_app_provider/screens/screen_sizes/small.dart';



class Homepage extends StatefulWidget {
  final int timeZone;
  const Homepage({Key? key, required this.timeZone}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  bool isCancel = false;



  @override
  void initState() {
    loadInterstitialAd();
    final dateProvider = Provider.of<DateProvider>(context, listen: false);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      dateProvider.getTime(widget.timeZone);
      if(isCancel == true){
        timer.cancel();
      }
      //debugPrint('${widget.timeZone}');
    });
    super.initState();


  }

  @override
  void dispose() {
    debugPrint('Disposed homepage');
    isCancel = true;
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    //debugPrint('build tree');
    Size size = MediaQuery.of(context).size;
   // debugPrint('${size.width}');
    return LayoutBuilder(builder: (context, constraint){
      debugPrint('${constraint.maxHeight}');
      if(constraint.maxHeight >= 750 && constraint.maxHeight < 900){
        return AndroidMedium(size: size, ad: buildUnityBannerAd(),);
      }
      else if(constraint.maxHeight < 750){
        return AndroidSmall(size: size, ad: buildUnityBannerAd(),);
      }
      else if(constraint.maxHeight >= 900){
        return AndroidLarge(size: size, ad: buildUnityBannerAd(),);
      }
      else{
        return AndroidMedium(size: size, ad: buildUnityBannerAd(),);
      }
    });
  }

  UnityBannerAd buildUnityBannerAd() {
    return UnityBannerAd(
      placementId: homeAdId,
      onLoad: (placementId) => debugPrint('Banner loaded: $placementId'),
      onClick: (placementId) => debugPrint('Banner clicked: $placementId'),
      onFailed: (placementId, error, message) => debugPrint('Banner Ad $placementId failed: $error $message'),
    );
  }


}


