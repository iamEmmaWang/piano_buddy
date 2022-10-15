import 'package:flutter/material.dart';
import "package:piano_buddy/Models/Song.dart";
import 'package:piano_buddy/Pages/SongPlayer.dart';

class PlayerModes extends StatelessWidget {
  const PlayerModes({Key? key, required this.data}) : super(key: key);
  final Song data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.songName),
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
                title: Text("Mode ${data.modes[index].modeVal}"),
                subtitle: Text("Plays: ${data.modes[index].pianoPlay}"),
                trailing: const Icon(Icons.menu),
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>SongPlayer(modeVal: data.modes[index].modeVal, playMode: data.modes[index].pianoPlay,))
                  );
                },
              ),
            ),
          );
        }, itemCount: data.modes.length)
    );
  }
}






