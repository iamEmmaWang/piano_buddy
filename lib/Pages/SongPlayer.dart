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
  int index = 0;
  late AnimationController iconController;
  late PdfController _pdfController;
  late final pagesCount = _pdfController.pagesCount;
  bool pdfLoaded = false;

  @override
  void initState() {
    super.initState();

    //just for debugging
    print("Time stamps for this mode: " + mode.turnTimeStamps.toString());
    print("Turns for this mode: " + mode.turnPages.toString());

    //don't let audio from other screens play on this one!
    MainPlayer.stop();

    //give player url from mode
    MainPlayer.loadURL(mode.audioLink);
    print(MainPlayer.isPlaying);

    iconController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _pdfController = PdfController(document: PdfDocument.openData(InternetFile.get(mode.pdfLink)));
  }

  @override
  dispose() {
    MainPlayer.stop();
    iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playing ${pianoPlayString(mode.piano)}"),
      ),
      body:
      Column(
        children: [
          Expanded(
            child: Center(
             child: PdfView(
               onDocumentLoaded: (document) {
                 setState(() {
                   pdfLoaded = true;
                 });
               },
               controller: _pdfController,
             ),
            ),
          ),
          if (pdfLoaded)
            Column(
              children: [
                StreamBuilder(
                    stream: MainPlayer.player.currentPosition,
                    builder: (context, asyncSnapshot) {
                      final Duration? duration = asyncSnapshot.data;
                      if(duration != null && index < mode.turnTimeStamps.length && duration.inMicroseconds > mode.turnTimeStamps[index]*pow(10,6)){
                        index++;
                        print("INDEX CHANGED, NEW INDEX IS " + index.toString());
                        if (index-1 < mode.turnPages.length) {
                          if (mode.turnPages[index-1] > 0)
                          {
                            print("FLIPPING FORWARD " + mode.turnPages[index-1].toString());
                            _pdfController.nextPage(duration: const Duration(microseconds: 1), curve: Curves.ease);
                          }
                          else if (mode.turnPages[index-1] < 0){
                            {
                              print("FLIPPING BACK " + mode.turnPages[index-1].toString());
                              _pdfController.animateToPage(_pdfController.page + mode.turnPages[index-1], duration: const Duration(microseconds: 1), curve: Curves.ease);
                            }
                          }
                        }
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

