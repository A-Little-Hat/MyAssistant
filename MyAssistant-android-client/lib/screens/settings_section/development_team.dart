import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class DevelopmentTeamSection extends StatelessWidget {
  const DevelopmentTeamSection({Key? key}) : super(key: key);

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
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Development Team',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 4,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/dev_Soumyaneel.jpeg'),
              ),
            ),
            const SizedBox(
              height: 65.0,
            ),
            const Text(
              'Soumyaneel Sarkar',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Department of Computer Science',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Kalyani Mahavidyalaya',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Transform.scale(
              scale: 4,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/dev_Vishal.jpg'),
              ),
            ),
            const SizedBox(
              height: 65.0,
            ),
            const Text(
              'Vishal Kumar Paswan',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Department of Computer Science',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Kalyani Mahavidyalaya',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
