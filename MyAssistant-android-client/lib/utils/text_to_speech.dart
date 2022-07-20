import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

class TextToSpeechModel {
  static Future speakText(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.95); // 0.5 - 1.5
    await flutterTts.speak(text);
  }
}
