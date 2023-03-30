import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/screens/splashScreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);

  runApp(const MyApp());
  await loadUnity();
}

loadUnity() async {
  await UnityAds.init(
    gameId: '5225188',
    testMode: false,
    onComplete: () => debugPrint('Initialization Complete'),
    onFailed: (error, message) => debugPrint('Initialization Failed: $error $message'),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchLocation()),
        ChangeNotifierProvider(create: (_) => ApiResponse()),
        ChangeNotifierProvider(create: (_) => DateProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),

      ),
    );
  }
}

