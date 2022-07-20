import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

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
        backgroundColor: const Color(0xFFfdfbfb),
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 2,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/icon.png'),
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
            const SizedBox(
              height: 6,
            ),
            const Text(
              'Makes your life simple.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Version 1.0',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 85, 18, 241),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
