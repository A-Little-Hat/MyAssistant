import 'dart:io';
import 'package:assistant/utils/text_to_speech.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

String fileName = 'Tap to select files';
bool isFileSelected = false;
late File file;
FilePickerResult? result;
late AnimationController shareFilesAnimationController;

Future<void> _asyncFileUpload(File file, BuildContext ctx) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    showUploadingAlertDialog(ctx);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String _userId = sharedPreferences.get('userId').toString();

    String url =
        'https://myassistantbackend.herokuapp.com/file?userId=$_userId';

    var request = http.MultipartRequest("POST", Uri.parse(url));
    var uploadFile = await http.MultipartFile.fromPath("file_field", file.path);
    request.files.add(uploadFile);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Navigator.pop(ctx);
    if (responseString == 'File uploaded') {
      TextToSpeechModel.speakText('File uploaded');
      showAlertDialog(
        ctx,
        'File uploaded',
        'assets/file_uploaded_animation.json',
      );
    } else {
      TextToSpeechModel.speakText('An error occured while uploading');
      showAlertDialog(
        ctx,
        'Error occured while uploading',
        'assets/file_not_uploaded_animation.json',
      );
    }
  } else {
    TextToSpeechModel.speakText(
        'Please check your internet connection and try again');
    showAlertDialog(ctx, 'Please check your internet connection and try again',
        'assets/no_internet_animation.json');
  }
}


showUploadingAlertDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    builder: (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset(
              'assets/uploading_animation.json',
              repeat: true,
            ),
            const Text(
              'Uploading file',
              style: TextStyle(
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
              controller: shareFilesAnimationController,
              onLoaded: (composition) {
                shareFilesAnimationController.duration = composition.duration;
                shareFilesAnimationController.forward();
              },
            ),
            Text(description,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center)
          ],
        ),
      ),
    ),
  );
}

class ShareFileSection extends StatefulWidget {
  const ShareFileSection({Key? key}) : super(key: key);

  @override
  State<ShareFileSection> createState() => _ShareFileSectionState();
}

class _ShareFileSectionState extends State<ShareFileSection>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    shareFilesAnimationController = AnimationController(vsync: this);

    shareFilesAnimationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        shareFilesAnimationController.reset();
      }
    });
  }

  @override
  void dispose() {
    shareFilesAnimationController.dispose();
    super.dispose();
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
        centerTitle: true,
        title: const Text(
          'MyShare',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xFFfdfbfb),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: screenBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                result = await FilePicker.platform.pickFiles();

                if (result != null) {
                  setState(() {
                    fileName = result!.files.first.name;
                    isFileSelected = true;
                  });
                  file = File(result!.files.single.path.toString());
                } else {
                  setState(() {
                    fileName = 'Tap to select files';
                  });
                }
              },
              child: Text(
                fileName,
                style: TextStyle(
                  fontFamily: GoogleFonts.nunito().fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Visibility(
              visible: isFileSelected,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    fileName = 'Tap to select files';
                    result = null;
                    isFileSelected = false;
                  });
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            InkWell(
              onTap: (() {
                if (result != null) {
                  _asyncFileUpload(file, context).whenComplete(() {
                    setState(() {
                      fileName = 'Tap to select files';
                      isFileSelected = false;
                      result = null;
                    });
                  });
                }
              }),
              child: Container(
                height: 54,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 85, 18, 241),
                ),
                child: Center(
                  child: Text(
                    'Share',
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
