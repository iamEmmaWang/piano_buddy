import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:piano_buddy/Models/Mode.dart';

class SongPlayer extends StatefulWidget {
  const SongPlayer({Key? key, required this.modeVal, required this.playMode}) : super(key: key);
  final String modeVal;
  final String playMode;
  @override
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> with SingleTickerProviderStateMixin {
  AssetsAudioPlayer player = AssetsAudioPlayer();
  late AnimationController iconController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    player.open(Audio("song_files/emodam.mp3"), autoStart: false);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mode ${widget.modeVal} Playing ${widget.playMode}"),
      ),
      body: Container(
        child: GestureDetector(
          child: AnimatedIcon(
            size: 100,
            icon: AnimatedIcons.play_pause,
            progress: iconController,
          ),
          onTap: () {
              setState(() {
                isPlaying != isPlaying;
                isPlaying ? iconController.forward() : iconController.reverse();
              });
          },
        ),
      ),
    );
  }

}
