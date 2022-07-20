import 'package:permission_handler/permission_handler.dart';

class PermissionRequests {
  static void permissionRequests() async {
    await [
      Permission.contacts,
      Permission.microphone,
      Permission.sms,
      Permission.phone,
      Permission.location,
    ].request();
  }
}
