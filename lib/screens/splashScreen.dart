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
    final locProvider = Provider.of<ApiResponse>(context, listen: false);
    var location = await determinePosition();
    debugPrint('Latitude: ${location.latitude}, Longitude: ${location.longitude}');
    await locProvider.getLocation('${location.latitude}', '${location.longitude}');
    _nextScreen(locProvider.timezone);

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
