import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/screens/components/changeIcons.dart';
import 'package:weather_app_provider/themes/themes.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:lottie/lottie.dart';


class Homepage extends StatefulWidget {
  final int timeZone;
  const Homepage({Key? key, required this.timeZone}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  bool isCancel = false;
  late final AnimationController controller;


  @override
  void initState() {

    super.initState();
    controller = AnimationController(vsync: this);
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
    controller.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    //debugPrint('build tree');
    return Scaffold(
      // appBar: appBar(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset('assets/rain_day.png', fit: BoxFit.fill, height: double.infinity,width: double.infinity,),
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
                      Text('${value.city}, ${value.country}', style: city(), textAlign: TextAlign.center, overflow: TextOverflow.visible,),
                      Consumer<DateProvider>(builder: (context,value,child){
                        String date = DateFormat.yMMMEd().add_jm().format(value.date);
                        return Text(date, style: time(),);
                      }),
                      Lottie.asset(
                        changeIcons(value.icon),
                        fit: BoxFit.fill
                      ),
                      Text('${value.temp.toString()}°C', style: temp(),),
                      const Spacer(),
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
                            children: [
                              const BoxedIcon(WeatherIcons.humidity, size: 30, color: whiteClr,),
                              Text('${value.humidity}', style: bottomText(),),
                              Text('%', style: bottomText(),)
                            ],
                          ),
                          Column(
                            children: [
                              Text('AQI', style: bottomText(),),
                              Text('${value.aqi}', style: bottomText(),),
                            ],
                          ),
                          Column(
                            children: [
                              const BoxedIcon(WeatherIcons.windy, size: 30, color: whiteClr,),
                              Text('${value.airSpeed}', style: bottomText(),),
                              Text('km/hr', style: bottomText(),)
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

  appBar(){
    return AppBar(
      title: Text('WeatherPo', style: title(),),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }
}
