import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/screens/navigationPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiResponse()),
        ChangeNotifierProvider(create: (_) => DateProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyNavPage()
      ),
    );
  }
}

