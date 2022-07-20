import 'package:assistant/screens/homepage.dart';
import 'package:assistant/utils/text_to_speech.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../constants.dart';

late AnimationController remindersAnimationController;

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
              controller: remindersAnimationController,
              onLoaded: (composition) {
                remindersAnimationController.duration = composition.duration;
                remindersAnimationController.forward();
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

class ReminderSection extends StatefulWidget {
  const ReminderSection({Key? key}) : super(key: key);

  @override
  State<ReminderSection> createState() => _ReminderSectionState();
}

class _ReminderSectionState extends State<ReminderSection>
    with SingleTickerProviderStateMixin {
  late String taskName;
  late int hour, minute;
  String time = '';
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool setReminder = true;

  final _taskKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    const androidInitialize = AndroidInitializationSettings('flutter');
    const iosinitialize = IOSInitializationSettings();
    const initializeSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iosinitialize,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializeSettings,
      onSelectNotification: notificationSelected,
    );

    remindersAnimationController = AnimationController(vsync: this);

    remindersAnimationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/homepage", (Route<dynamic> route) => false);
        remindersAnimationController.reset();
      }
    });
  }

  @override
  void dispose() {
    remindersAnimationController.dispose();
    super.dispose();
  }

  Future _showNotification() async {
    if (time != '') {
      if (_taskKey.currentState!.validate()) {
        setState(() {
          setReminder = false;
        });
        const androidDetails = AndroidNotificationDetails(
          "MyAssistant ID",
          "MyAssistant",
          importance: Importance.max,
        );
        const iOSDetails = IOSNotificationDetails();
        const generalNotificationDetails =
            NotificationDetails(android: androidDetails, iOS: iOSDetails);

        var scheduledTime = DateTime.parse(time);

        // ignore: deprecated_member_use
        flutterLocalNotificationsPlugin.schedule(
          0,
          taskName,
          "Get your task done!",
          scheduledTime,
          generalNotificationDetails,
        );
        TextToSpeechModel.speakText('Reminder added');
        showAlertDialog(
            context, 'Reminder added', 'assets/reminder_added_animation.json');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'MyReminders',
          style: TextStyle(
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFFfdfbfb),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                key: _taskKey,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Your task cannot be empty";
                  }
                  return null;
                },
                showCursor: false,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  color: Colors.white,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your task',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.nunito().fontFamily,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 110, 47, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (_val) {
                  taskName = _val;
                },
              ),
            ),
            const SizedBox(height: 10),
            DateTimePicker(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Select time',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: GoogleFonts.nunito().fontFamily,
                color: Colors.black,
                fontSize: 20,
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
              onTap: _showNotification,
              child: Container(
                height: 54,
                width: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 85, 18, 241),
                ),
                child: Center(
                  child: Text(
                    'Schedule Task',
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

  Future notificationSelected(String? payload) async {
    Get.offAll(() => const HomepageScreen());
  }
}
