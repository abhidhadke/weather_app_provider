import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import '../../network/api_response.dart';
import '../../themes/themes.dart';
import '../components/appBar.dart';
import '../components/changeBG.dart';
import '../components/changeIcons.dart';


class AndroidSmall extends StatelessWidget {
  const AndroidSmall({
    super.key,
    required this.size, required this.bannerAd,
  });

  final Size size;
  final BannerAd? bannerAd;

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: size.width,
                  height: size.height * 1.1,
                  child: Consumer<ApiResponse>(
                    builder: (context, value, child){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: bannerAd!.size.width.toDouble(),
                              height: bannerAd!.size.height.toDouble(),
                              child: AdWidget(
                                  ad: bannerAd!),
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
                            SizedBox(height: size.height*0.1,)



                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}