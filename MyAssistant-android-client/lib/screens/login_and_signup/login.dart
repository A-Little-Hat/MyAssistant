import 'dart:convert';
import 'package:assistant/screens/homepage.dart';
import 'package:assistant/screens/login_and_signup/signup.dart';
import 'package:assistant/utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import '../../utils/text_to_speech.dart';

Future<dynamic> fetchLoginDetails(String _email, String _password) async {
  String url =
      'https://myassistantbackend.herokuapp.com/login?email=$_email&password=$_password';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  int status = response.statusCode;

  switch (status) {
    case 202:
      final decodedJson = json.decode(response.body);
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('email', _email);
      sharedPreferences.setString('userId', decodedJson['code']);
      sharedPreferences.setString('name', decodedJson['name']);
      TextToSpeechModel.speakText('Hello ${sharedPreferences.get('name')}');
      Get.to(() => const HomepageScreen());
      break;
    case 401:
      const snackBar = SnackBar(
        content: Text('Invalid login credentials.'),
      );
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool changeButton = false;
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: screenBackground,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/icon.png'),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'MyAssistant',
                          textStyle: const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 85, 18, 241),
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(
                            milliseconds: 200,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Makes your life simple.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 54, 4, 172),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      controller: userIdController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 85, 18, 241),
                      ),
                      decoration: const InputDecoration(
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),

                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
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
                        if (value!.isEmpty) return "Username cannot be empty";
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 85, 18, 241)),
                      decoration: const InputDecoration(
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
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
                        } else if (value.length < 8) {
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
                          fetchLoginDetails(
                              userIdController.text, passwordController.text);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: const Center(
                            child: Text(
                              'Login',
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
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            Get.to(SignupScreen());
                          },
                          child: const Text('Signup'),
                        )
                      ],
                    ),
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
