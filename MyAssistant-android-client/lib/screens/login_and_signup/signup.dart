// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:assistant/screens/homepage.dart';
import 'package:assistant/utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../utils/text_to_speech.dart';

Future<dynamic> signUpDetails(
    String _name, String _email, String _password) async {
  String url =
      'https://myassistantbackend.herokuapp.com/signup?name=$_name&email=$_email&password=$_password';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  int status = response.statusCode;
  print("status" + status.toString());

  switch (status) {
    case 201:
      print(response.body);
      final decodedJson = json.decode(response.body);
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('email', _email);
      sharedPreferences.setString('userId', decodedJson['code']);
      sharedPreferences.setString('name', decodedJson['name']);
      TextToSpeechModel.speakText('Welcome to my assistant');
      Get.to(const HomepageScreen());
      break;
    case 205:
      const snackBar = SnackBar(
        content: Text('Signup credentials already in use.'),
      );

      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      print(response.body);
      break;
    default:
      const snackBar = SnackBar(
        content: Text('Something went wrong, please try again later.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
      break;
  }
}

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: screenBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey there,',
                      style: TextStyle(
                        color: Color.fromARGB(255, 85, 18, 241),
                        fontWeight: FontWeight.w400,
                        fontSize: 26.0,
                      ),
                    ),
                    const Text(
                      'Signup',
                      style: TextStyle(
                        color: Color.fromARGB(255, 85, 18, 241),
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 85, 18, 241),
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          CupertinoIcons.person,
                          color: Color.fromARGB(255, 85, 18, 241),
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 85, 18, 241),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return "Name cannot be empty";
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 85, 18, 241),
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          CupertinoIcons.mail,
                          color: Color.fromARGB(255, 85, 18, 241),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 85, 18, 241),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return "Email cannot be empty";
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 85, 18, 241),
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          CupertinoIcons.lock_fill,
                          color: Color.fromARGB(255, 85, 18, 241),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 85, 18, 241),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 6) {
                          return "Password cannot be less than 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 70.0,
                      ),
                      child: InkWell(
                        onTap: () {
                          signUpDetails(
                            _nameController.text,
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(255, 85, 18, 241),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            Get.toNamed('/login');
                          },
                          child: const Text('Login'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
