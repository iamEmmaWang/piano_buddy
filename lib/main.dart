import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:piano_buddy/Models/Song.dart';
import 'package:piano_buddy/Pages/Splash.dart';

void main() async {
  await getSongDictionary();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: Splash()
    );
  }
}

