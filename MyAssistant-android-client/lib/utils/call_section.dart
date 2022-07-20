import 'package:assistant/utils/fetch_contact_details.dart';
import 'package:assistant/utils/text_to_speech.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../models/contact_details.dart';

class CallSection {
  static List<Contact>? contactList;

  static void makeACall(String contactName) async {
    ContactDetails _contactDetails =
        await FetchContactDetails.getContactNumber(contactName);
    if (_contactDetails.isContactFound) {
      TextToSpeechModel.speakText('Calling ${_contactDetails.contactName}');

      Future.delayed(
        const Duration(seconds: 2),
        () async {
          await FlutterPhoneDirectCaller.callNumber(
              (_contactDetails.contactNumber).toString());
        },
      );
    } else if (_contactDetails.isContactFound == false) {
      TextToSpeechModel.speakText("Contact not found");
    }
  }
}
