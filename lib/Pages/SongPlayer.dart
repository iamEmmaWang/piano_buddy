import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:piano_buddy/Models/Mode.dart';

class SongPlayer extends StatefulWidget {
  const SongPlayer({Key? key, required this.modeval}) : super(key: key);
  final String modeval;
  @override
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.open(Audio("song_files/emodam.mp3"));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(onPressed: (){
          player.play();
        }, child: Text("Are you hurt?"),),
      )
    );
  }
}