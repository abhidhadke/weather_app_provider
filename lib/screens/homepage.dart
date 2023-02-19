import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/themes/themes.dart';



class Homepage extends StatefulWidget {
  final int timeZone;
  const Homepage({Key? key, required this.timeZone}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              child: Consumer<ApiResponse>(
                builder: (context, value, child){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${value.city}, ${value.country}', style: city()),
                      Text(DateFormat.yMMMd().add_jm().format(value.date), style: time(),),
                      Text('${value.temp.toString()}°C', style: temp(),),
                      const Text('-------------------', style: TextStyle(color: Colors.white),),
                      Text(value.tempDescp, style: description(),),
                      Text('high/low temp', style: smallTemp(),),
                      const Text('------------------------', style: TextStyle(color: Colors.white),),



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
