import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/network/api_response.dart';
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



  @override
  void initState() {

    super.initState();
    final dateProvider = Provider.of<DateProvider>(context, listen: false);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      dateProvider.getTime(widget.timeZone);

      if(isCancel == true){
        timer.cancel();
      }
      //debugPrint('${widget.timeZone}');
    });

  }

  @override
  void dispose() {
    isCancel = true;
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    //debugPrint('build tree');
    return Scaffold(
      appBar: appBar(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //
          Image.asset('assets/wallpapers/day.png', fit: BoxFit.fill, height: double.infinity,width: double.infinity,),
          Container(decoration: const BoxDecoration(color: Colors.black12),),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Consumer<ApiResponse>(
                builder: (context, value, child){
                 // debugPrint('outside consumer');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      Text('${value.city}, ${value.country}', style: city(), textAlign: TextAlign.center,maxLines: 2, overflow: TextOverflow.ellipsis,),
                      Consumer<DateProvider>(builder: (context,value,child){
                        String date = DateFormat.yMMMEd().add_jm().format(value.date);
                        return Text(date, style: time(),);
                      }),
                      const Spacer(),
                      Lottie.asset(
                        changeIcons(value.icon),
                        fit: BoxFit.fill
                      ),
                      Text('${value.temp.toString()}°C', style: temp(),),
                      const Text('- - - - - - - - - - - - - - - - - - - - - - - -', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
                      Text(value.tempDescp, style: description(),),
                      Text('${value.maxTemp} / ${value.minTemp} °C', style: smallTemp(),),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      const Text('- - - - - - - - - - - - - - - - - - - - - - - -', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const BoxedIcon(WeatherIcons.humidity, size: 25, color: whiteClr,),
                              Text('${value.humidity}', style: bottomText(),),
                              Text('%', style: bottomText(),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('AQI', style: bottomText(),),
                              Text('${value.aqi}', style: bottomText(),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const BoxedIcon(WeatherIcons.windy, size: 25, color: whiteClr,),
                              Text('${value.airSpeed}', style: bottomText(),),
                              Text('m/s', style: bottomText(),)
                            ],
                          )

                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.07,)



                    ],
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
