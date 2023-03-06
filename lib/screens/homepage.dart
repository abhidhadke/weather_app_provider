import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/screens/components/changeBG.dart';
import 'package:weather_app_provider/screens/components/changeIcons.dart';
import 'package:weather_app_provider/themes/themes.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:lottie/lottie.dart';
import 'components/appBar.dart';


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

  //TODO: change this Id to my ID
  final adUnitId = 'ca-app-pub-3940256099942544/2934735716';

  //loads ad
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
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
    isCancel = true;
    _bannerAd?.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    //debugPrint('build tree');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(size),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //
          Consumer<ApiResponse>(builder: (context, value, child){
            return Image.asset(changeBg(value.id, value.icon), fit: BoxFit.fill, height: double.infinity,width: double.infinity,);

          }),
          Container(decoration: const BoxDecoration(color: Colors.black12),),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Consumer<ApiResponse>(
                builder: (context, value, child){
                 // debugPrint('outside consumer');
                  //debugPrint(value.icon);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         SizedBox(
                           width: _bannerAd!.size.width.toDouble(),
                           height: _bannerAd!.size.height.toDouble(),
                           child: AdWidget(
                               ad: _bannerAd!),
                         ),
                        Text('${value.city}, ${value.country}', style: city(size.width*0.11), textAlign: TextAlign.center,maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true,),
                        Consumer<DateProvider>(builder: (context,value,child){
                          String date = DateFormat.yMMMEd().add_jm().format(value.date);
                          return Text(date, style: time(size.width*0.07),);
                        }),
                        const Spacer(),
                        SizedBox(
                          height: size.width*0.2,
                          child: Lottie.asset(
                            changeIcons(value.icon),
                            fit: BoxFit.fill
                          ),
                        ),
                        Text('${value.temp.toString()}°C', style: temp(size.width*0.17),),
                         Text('- - - - - - - - - - - - - - - - - - - - - - - -', style: TextStyle(color: Colors.white, fontSize: size.width*0.052, fontWeight: FontWeight.w600),),
                        Text(value.tempDescp, style: description(size.width*0.07),),
                        Text('${value.maxTemp} / ${value.minTemp} °C', style: smallTemp(size.width*0.07),),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                         Text('- - - - - - - - - - - - - - - - - - - - - - - -', style: TextStyle(color: Colors.white, fontSize: size.width*0.052, fontWeight: FontWeight.w600),),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 BoxedIcon(WeatherIcons.humidity, size: size.width*0.06, color: whiteClr,),
                                Text('${value.humidity}', style: bottomText(size.width*0.05),),
                                Text('%', style: bottomText(size.width*0.05),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('AQI', style: bottomText(size.width*0.06),),
                                Text('${value.aqi}', style: bottomText(size.width*0.06),),
                                Text(value.aqiDesc, style: bottomText(size.width*0.04),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 BoxedIcon(WeatherIcons.windy, size: size.width*0.06, color: whiteClr,),
                                Text('${value.airSpeed}', style: bottomText(size.width*0.05),),
                                Text('m/s', style: bottomText(size.width*0.05),)
                              ],
                            )

                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.076,)



                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }


}
