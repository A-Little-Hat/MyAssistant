import 'dart:async';
import 'package:assistant/constants.dart';
import 'package:assistant/screens/settings_section/settings.dart';
import 'package:assistant/utils/assistant_operations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:weather/weather.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final WeatherFactory wf = WeatherFactory('6d7b8aa0f6a34dd44744f2dc19f95b2f');
  double? latitude;
  double? longitude;
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  late bool? _speechEnabled;
  late String _lastWords = '';
  late bool isDataAvailable = true;
  late int? temperature = 0;
  late String? description = 'null';
  String? userName;
  late String? location = 'null';
  bool isMicActive = false;

  Future<void> getLatitudeAndLongitude() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    latitude = sharedPreferences.getDouble('latitude');
    longitude = sharedPreferences.getDouble('longitude');
  }

  Future<void> setName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    userName = sharedPreferences.getString('name');
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    setName().whenComplete(() {
      getLatitudeAndLongitude().whenComplete(() {
        fetchWeatherData().whenComplete(() {
          _initSpeech();
        });
      });
    });

    super.initState();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();

    setState(() {
      _lastWords = _speechEnabled == false
          ? "User denied microphone permissions"
          : "What can I do for you?";
    });
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      partialResults: false,
    );
    setState(() {
      isMicActive = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _lastWords = "What can I do for you?";
      isMicActive = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });

    AssistantOperations.selectTask(_lastWords);
  }

  Future fetchWeatherData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Weather weatherData =
        await wf.currentWeatherByLocation(latitude!, longitude!);

    setState(() {
      location = weatherData.areaName;
      sharedPreferences.setString('location', location!);
      temperature = weatherData.temperature?.celsius?.round();
      sharedPreferences.setInt('temperature', temperature!);
      description = weatherData.weatherDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "MyAssistant",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: const Color(0xFFfdfbfb),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(const SettingsSection());
              },
              icon: const Icon(
                CupertinoIcons.settings_solid,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Container(
          decoration: screenBackground,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.location,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 2.5,
                      ),
                      Text(
                        location!,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.thermometer,
                        color: Colors.blue,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 2.5,
                      ),
                      Text(
                        '${temperature!.toString()}°C, $description',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: !isMicActive,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/hello_animation.json',
                      ),
                      Text(
                        'Hello $userName. 👋',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  replacement: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Visibility(
                        visible: isMicActive,
                        child: Lottie.asset(
                          'assets/wave_animation.json',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _lastWords,
                      style: TextStyle(
                        fontFamily: GoogleFonts.nunito().fontFamily,
                        fontSize: 27,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            _startListening();
            Future.delayed(
                const Duration(
                  seconds: 6,
                ), () {
              _stopListening();
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(255, 85, 18, 241),
            ),
            width: 75,
            height: 75,
            child: Icon(
              isMicActive ? Icons.mic_rounded : Icons.mic_off_rounded,
              size: 26,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
