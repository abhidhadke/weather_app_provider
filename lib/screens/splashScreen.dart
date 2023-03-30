import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/screens/navigationPage.dart';
import '../network/location.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    determineLocation();

  }

  Future<void> determineLocation() async {
    try{
      final locProvider = Provider.of<ApiResponse>(context, listen: false);
      var location = await determinePosition();
      debugPrint('Latitude: ${location.latitude}, Longitude: ${location.longitude}');
      int res = await locProvider.getLocation('${location.latitude}', '${location.longitude}');
      if(res==1){
        _nextScreen(locProvider.timezone);
      }else{
        Future.delayed(const Duration(seconds: 2),() async {
          await determineLocation();
        });
      }
    }catch(e){
      debugPrint('$e');
    }

  }



  _nextScreen(int timezone){
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  MyNavPage(timezone: timezone)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
        child: const Center(
         child: RiveAnimation.asset('assets/splash_screen.riv'),
        ),
      ),
    );
  }
}
