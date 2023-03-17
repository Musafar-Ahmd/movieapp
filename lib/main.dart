import 'package:flutter/material.dart';
import 'package:movieapp/widgets/Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner:false ,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      home: SplashScreen(),
    );
  }
}

