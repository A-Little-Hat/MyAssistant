import 'package:assistant/utils/fetch_contact_details.dart';
import 'package:assistant/utils/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_details.dart';

// final FlutterTts flutterTts = FlutterTts();

// Future speak(String text) async {
//   await flutterTts.setLanguage("en-US");
//   await flutterTts.setPitch(1.5); // 0.5 - 1.5
//   await flutterTts.speak(text);
// }

class SendSMS {
  static TextEditingController messageController = TextEditingController();

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static void sendMessage(BuildContext context, String operation) async {
    String contactName = operation.substring(operation.lastIndexOf('to') + 3);
    ContactDetails _contactDetails =
        await FetchContactDetails.getContactNumber(contactName);

    if (_contactDetails.isContactFound) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            title: Text(
              "Send a message to ${(_contactDetails.contactName)}",
              style: TextStyle(
                fontFamily: GoogleFonts.nunito().fontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            content: TextField(
              decoration: const InputDecoration(
                hintText: 'Type your message...',
              ),
              controller: messageController,
              onChanged: (value) {},
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  TextToSpeechModel.speakText(
                      'Sending message to ${_contactDetails.contactName}');
                  Uri smsUri = Uri(
                    scheme: 'sms',
                    path: '${(_contactDetails.contactNumber)}',
                    query: encodeQueryParameters(
                        <String, String>{'body': messageController.text}),
                  );
                  await launch(smsUri.toString());
                  Navigator.pop(context);
                },
                child: const Text('Send'),
              ),
            ],
          );
        },
      );
      return;
    } else if (_contactDetails.isContactFound == false) {
      TextToSpeechModel.speakText("Contact not found");
    }
  }
}
