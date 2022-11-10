import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';
import 'package:piano_buddy/Models/Song.dart';
import '../MainPlayer.dart';

class SongPlayer extends StatefulWidget {
  const SongPlayer({Key? key, required this.mode}) : super(key: key);
  final Mode mode;

  @override
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> with SingleTickerProviderStateMixin {

  late Mode mode = widget.mode;
  late AnimationController iconController;
  late final pdfController = PdfController(document: PdfDocument.openData(InternetFile.get(mode.pdfLink)));

  @override
  void initState() {
    super.initState();

    //don't let audio from other screens play on this one!
    if (MainPlayer.isPlaying) MainPlayer.stop();

    //give player url from mode
    MainPlayer.loadURL(mode.audioLink);
    print(MainPlayer.isPlaying);

    iconController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playing ${pianoPlayString(mode.piano)}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: PdfView(
                controller: pdfController,
              )
            ),
          ),
          Center(
            child: GestureDetector(
              child: AnimatedIcon(
                size: 100,
                icon: AnimatedIcons.play_pause,
                progress: iconController,
              ),
              onTap: () {
                playAnimation();
                MainPlayer.isPlaying ? MainPlayer.play() : MainPlayer.pause();
              },
            ),
          ),
        ],
      )
    );
  }

   void playAnimation(){
     setState(() {
       MainPlayer.isPlaying = !MainPlayer.isPlaying;
       MainPlayer.isPlaying ? iconController.forward() : iconController.reverse();
     });
   }


}

