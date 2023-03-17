
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movieapp/widgets/Loginpage.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    Timer(const Duration(seconds: 5),()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const LoginValidation())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Image.asset("assets/images/iconmvt.png")],
        ),
      ),
    );
  }


}
