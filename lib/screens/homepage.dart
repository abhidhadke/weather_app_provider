import 'package:flutter/material.dart';
import 'package:weather_app_provider/themes/themes.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
                  Text('Time', style: time(),),
                  Text('Temperature', style: temp(),),
                  const Text('-------------------', style: TextStyle(color: Colors.white),),
                  Text('temp descrip', style: description(),),
                  Text('high/low temp', style: smallTemp(),),
                  const Text('------------------------', style: TextStyle(color: Colors.white),),

                ],
              ),
            ),
          )
        ],
      )
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
