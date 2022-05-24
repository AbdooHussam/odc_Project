import 'package:flutter/material.dart';
import 'package:odc/Screens/Home/Home_View.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/OnBoarding/on_boarding_screen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
   String? access;

  delay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove("access_token");
    // await prefs.remove("refresh_token");
    access = prefs.getString("access_token");
    Future.delayed(const Duration(seconds: 1), () {
      (access == null)
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const OnBoardingScreen()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delay();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Image.asset(
              "images/Logo.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
