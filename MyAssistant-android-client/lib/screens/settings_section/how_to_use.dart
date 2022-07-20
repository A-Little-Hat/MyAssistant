import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';

void _launchDesktopSite() async {
  if (await canLaunch('https://myassistantweb.netlify.app/')) {
    await launch('https://myassistantweb.netlify.app/');
  }
}

class HowToUseSection extends StatelessWidget {
  const HowToUseSection({Key? key}) : super(key: key);

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
          'How to use?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.nunito().fontFamily,
          ),
        ),
        backgroundColor: const Color(0xFFfdfbfb),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MyAssistant is a voice assistant app for managing all your daily tasks with ease. Tap on the microphone button and speak any command to perform your tasks.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.phone,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Call YourContactName" to make a call.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.mail,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Send a message to YourContactName" to send a text.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.music_note_2,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Play some music" to groove on some beats.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.thermometer_sun,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "How\'s the weather" to get weather details of your location.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.pen,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Add notes" to add some notes.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.pencil_ellipsis_rectangle,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Open notes" to access all your notes.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.bell,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Set a reminder" to get reminders of your important tasks.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.alarm,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Set an alarm" to set an alarm.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.search,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Who is PersonName" or "Where is LocationName" or "How to YourDoubt" search any of your queries.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(
                        CupertinoIcons.arrow_right_square,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: Text(
                        'Say "Open AppName" to open any application.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.share,
                        color: Color.fromARGB(255, 85, 18, 241),
                        size: 30,
                      ),
                      title: const Text(
                        'Say "Share files" to send files to your PC.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Just visit the url on your PC given below and sign in with your login credentials.',
                            style: TextStyle(
                              // fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: InkWell(
                              onTap: _launchDesktopSite,
                              child: Text(
                                'https://myassistantweb.netlify.app/',
                                style: TextStyle(
                                  color: Colors.blue.shade600,
                                  fontSize: 15,
                                  // fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
