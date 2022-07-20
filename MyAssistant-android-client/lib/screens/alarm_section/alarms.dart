import 'package:assistant/utils/text_to_speech.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

late AnimationController alarmAnimationController;

showAlertDialog(
    BuildContext context, String description, String animationPath) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset(
              animationPath,
              repeat: false,
              controller: alarmAnimationController,
              onLoaded: (composition) {
                alarmAnimationController.duration = composition.duration;
                alarmAnimationController.forward();
              },
            ),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
  );
}

class AlarmClockSection extends StatefulWidget {
  const AlarmClockSection({Key? key}) : super(key: key);

  @override
  State<AlarmClockSection> createState() => _AlarmClockSectionState();
}

class _AlarmClockSectionState extends State<AlarmClockSection>
    with SingleTickerProviderStateMixin {
  String time = '';
  late int hour = 0, minute = 0;

  @override
  void initState() {
    super.initState();

    alarmAnimationController = AnimationController(vsync: this);

    alarmAnimationController.addStatusListener(
      (status) async {
        if (status == AnimationStatus.completed) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/homepage", (Route<dynamic> route) => false);
          alarmAnimationController.reset();
        }
      },
    );
  }

  @override
  void dispose() {
    alarmAnimationController.dispose();
    super.dispose();
  }

  void _setAlarm() {
    if (time != '') {
      hour =
          int.parse(time.substring(time.indexOf(' ') + 1, time.indexOf(':')));
      minute = int.parse(time.substring(time.indexOf(':') + 1));
      FlutterAlarmClock.createAlarm(hour, minute);
      showAlertDialog(context, 'Alarm added', 'assets/alarm_animation.json');
      TextToSpeechModel.speakText(
          'Alarm added for $hour hours and $minute minutes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xFFfdfbfb),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'MyAlarm',
          style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: screenBackground,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DateTimePicker(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Select time',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 22,
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: GoogleFonts.nunito().fontFamily,
                color: const Color.fromARGB(255, 85, 18, 241),
                fontSize: 30,
              ),
              type: DateTimePickerType.time,
              initialValue: '',
              firstDate: DateTime(2022),
              lastDate: DateTime(2023),
              dateLabelText: 'Date',
              onChanged: (val) {
                String currentDateTimeTime = DateTime.now().toString();
                String currentDate = currentDateTimeTime.substring(
                    0, currentDateTimeTime.indexOf(' '));
                val = currentDate + " " + val;
                time = val;
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: _setAlarm,
              child: Container(
                height: 54,
                width: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 85, 18, 241),
                ),
                child: Center(
                  child: Text(
                    'Set Alarm',
                    style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
