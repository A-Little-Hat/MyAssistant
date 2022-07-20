import 'package:device_apps/device_apps.dart';

class FetchInstalledAppList {
  static Future<String?> getPackageName(String appName) async {
    late List<Application> installedApps;
    String? _packageName;
    installedApps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true,
    );
    for (int i = 0; i < installedApps.length; i++) {
      if (appName
              .toLowerCase()
              .compareTo(installedApps[i].appName.toLowerCase()) ==
          0) {
        _packageName = installedApps[i].packageName;
        break;
      }
    }
    return _packageName;
  }
}
