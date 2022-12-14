import 'package:flutter/material.dart';
import 'package:piano_buddy/MainPlayer.dart';
import "package:piano_buddy/Models/Song.dart";
import 'package:piano_buddy/Pages/SongPlayer.dart';

class PlayerModes extends StatelessWidget {
  const PlayerModes({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  Widget build(BuildContext context) {

    //if it's playing, stop that music
    MainPlayer.stop();

    return Scaffold(
      appBar: AppBar(
        title: Text(song.songName),
      ),
        body: ListView.builder(itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(11),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(251, 220, 149, 2.0),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.amberAccent, width: 8)
              ),
              child: ListTile(
                leading: const Icon(Icons.music_note_rounded),
                title: Text(pianoPlayString(song.modes[index].piano)),
                trailing: const Icon(Icons.menu),
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>SongPlayer(mode: song.modes[index]))
                  );
                },
              ),
            ),
          );
        }, itemCount: song.modes.length)
    );
  }
}






