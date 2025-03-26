import 'package:flutter/material.dart';
import 'package:piano_buddy/Pages/PlayerModes.dart';
import 'package:piano_buddy/Pages/Splash.dart';

import '../Models/Song.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.music_note_rounded),
        title: const Text("Music List"),
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      body: ListView.builder(
          itemCount: songDictionary.length,
          itemBuilder: (BuildContext context, int index){
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
                  title: Text(songDictionary.entries.elementAt(index).value.songName),
                  subtitle: Text(songDictionary.entries.elementAt(index).value.composer),
                  trailing: const Icon(Icons.menu),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>PlayerModes(song: songDictionary.entries.elementAt(index).value))
                    );
                  },
                ),
              ),
            );
          }
        )
    );
  }
}
