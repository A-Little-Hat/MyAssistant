// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:assistant/screens/homepage.dart';
import 'package:assistant/screens/login_and_signup/login.dart';
import 'package:assistant/utils/get_weather_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getCurrentPosition() async {
    GetPositionDetails.getLocation();
  }

  @override
  void initState() {
    getCurrentPosition().whenComplete(() {
      getvalidationData().whenComplete(() async {
        Timer(
          Duration(seconds: 3),
          () => Get.to(
            finalEmail == null ? () => LoginScreen() : () => HomepageScreen(),
          ),
        );
      });
    });

    super.initState();
  }

  void setTemperatureFormat() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (sharedPreferences.get('temperature') == null) {
      sharedPreferences.setString('temperature', 'celsius');
    }
  }

  Future getvalidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var obtainedemail = sharedPreferences.getString('email');

    setState(() {
      finalEmail = obtainedemail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'route',
                transitionOnUserGestures: false,
                child: Transform.scale(
                  scale: 2,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/icon.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                'MyAssistant',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
