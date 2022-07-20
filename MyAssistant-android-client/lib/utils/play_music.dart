import 'package:assistant/utils/text_to_speech.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class MusicSection {
  static const List<String> spotifyPlaylist = [
    'https://open.spotify.com/track/4ujalVER2NLazVozUVllxw?si=d1mU7SmOTjWZ5p04-D678w&utm_source=whatsapp',
    'https://open.spotify.com/track/29m79w9xPMH4YCD6r8JSmV?si=7mm2wV1VRxGE2WcBoxiB4w&utm_source=whatsapp',
    'https://open.spotify.com/track/0yCWDaAgOtg6TKlNCg9rwA?si=yvI_Ux6SRJupD4C5dFKO5A&utm_source=whatsapp',
    'https://open.spotify.com/track/7lvDsmTRXFE3dK4OjvRiWB?si=uttxysbhRB20oPmyxsOtDA&utm_source=whatsapp',
    'https://open.spotify.com/track/27SdWb2rFzO6GWiYDBTD9j?si=o0Umt43nSQuDDK7t3loHaQ&utm_source=whatsapp',
    'https://open.spotify.com/track/6hF9F76wq0rpXxZxvmEA2e?si=6O-EwMX6Rxe_MdZzNONQ3Q&utm_source=whatsapp',
    'https://open.spotify.com/track/2qgXrzJsry4KgYoJCpuaul?si=ML5gaNWXSoqtNq4P9Q76Tw&utm_source=whatsapp',
    'https://open.spotify.com/track/5O2P9iiztwhomNh8xkR9lJ?si=XnrshzNlT9WbVhCdqAmZEg&utm_source=whatsapp',
    'https://open.spotify.com/track/7qiZfU4dY1lWllzX7mPBI3?si=AMMzVH_IT322NcH7iz3c8A&utm_source=whatsapp',
    'https://open.spotify.com/track/2J2Z1SkXYghSajLibnQHOa?si=yzA3ng4ATbuAao1OaHyxjQ&utm_source=whatsapp',
  ];

  static const List<String> ytMusicPlaylist = [
    'https://music.youtube.com/watch?v=ymT3Z_OuUes&feature=share',
    'https://music.youtube.com/watch?v=x18b0D8sTwo&feature=share',
    'https://music.youtube.com/watch?v=3jsGQczuplw&feature=share',
    'https://music.youtube.com/watch?v=vKb9xwSRrsU&feature=share',
    'https://music.youtube.com/watch?v=AUfALRGInd4&feature=share',
    'https://music.youtube.com/watch?v=AqgLhRRePZQ&feature=share',
    'https://music.youtube.com/watch?v=1puGzGe_mfU&feature=share',
    'https://music.youtube.com/watch?v=8BiLurrzFRw&feature=share',
    'https://music.youtube.com/watch?v=xTvyyoF_LZY&feature=share',
    'https://music.youtube.com/watch?v=I90KY3HNm0Y&feature=share',
  ];
  static void playMusic() async {
    bool isSpotifyInstalled =
        await DeviceApps.isAppInstalled('com.spotify.music');
    bool isYTMusicInstalled = await DeviceApps.isAppInstalled(
        'com.google.android.apps.youtube.music');

    Random random = Random();
    int randomNumber = random.nextInt(10);

    TextToSpeechModel.speakText('Playing music');

    if (isSpotifyInstalled) {
      await launch(spotifyPlaylist[randomNumber]);
    } else if (isYTMusicInstalled) {
      await launch(ytMusicPlaylist[randomNumber]);
    } else {
      await launch(spotifyPlaylist[randomNumber]);
    }
  }
}
