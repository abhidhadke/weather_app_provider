import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
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
  BannerAd? _bannerAd;
  //bool _isLoaded = false;



  //loads ad
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: homeAdId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('Ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }


  @override
  void initState() {

    loadInterstitialAd();
    loadAd();
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
    _bannerAd?.dispose();
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
        return AndroidMedium(size: size, bannerAd: _bannerAd,);
      }
      else if(constraint.maxHeight < 750){
        return AndroidSmall(size: size, bannerAd: _bannerAd,);
      }
      else if(constraint.maxHeight >= 900){
        return AndroidLarge(size: size, bannerAd: _bannerAd,);
      }
      else{
        return AndroidMedium(size: size, bannerAd: _bannerAd,);
      }
    });
  }


}


