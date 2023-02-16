import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/themes/themes.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dateProvider = Provider.of<DateProvider>(context, listen: false);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      dateProvider.dateTime();
      //debugPrint('timer');
    });
  }



  @override
  Widget build(BuildContext context) {

    debugPrint('build tree');
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('City', style: city()),
                  Consumer<DateProvider>(
                      builder: (context,value,child){
                        //value.dateTime();
                        String date = DateFormat.yMMMEd().add_jm().format(value.date);
                        return Text(date, style: time(),);
                      }),
                  Text('Temp', style: temp(),),
                  const Text('-------------------', style: TextStyle(color: Colors.white),),
                  Text('temp descrip', style: description(),),
                  Text('high/low temp', style: smallTemp(),),
                  const Text('------------------------', style: TextStyle(color: Colors.white),),



                ],
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
