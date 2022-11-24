import 'dart:async';
import 'dart:math';


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
  late Stream pagesStream;
  late Mode mode = widget.mode;
  List checkpoints = [5,9,15];
  int index = 0;
  late AnimationController iconController;
  late PdfController _pdfController;
  late final pagesCount = _pdfController.pagesCount;

  @override
  void initState() {
    super.initState();

    //don't let audio from other screens play on this one!
    if (MainPlayer.isPlaying) MainPlayer.stop();

    //give player url from mode
    MainPlayer.loadURL(mode.audioLink);
    print(MainPlayer.isPlaying);

    iconController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _pdfController = PdfController(document: PdfDocument.openData(InternetFile.get(mode.pdfLink)));

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
               controller: _pdfController,
             ),
            ),
          ),
          StreamBuilder(
              stream: MainPlayer.player.currentPosition,
              builder: (context, asyncSnapshot) {
                final Duration? duration = asyncSnapshot.data;
                if(duration != null && duration.inMicroseconds > checkpoints[index]*pow(10,6) && index < checkpoints.length){
                  index++;
                  _pdfController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
                }return Text(duration.toString());
              }
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

