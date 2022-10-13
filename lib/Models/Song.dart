

/*
* This file is the model for Song
* Song so far will have songName, artist
* */
import 'Mode.dart';
class Song{
  String songName;
  String composer;
  List<Mode> modes = [
    Mode(modeVal: "1", pianoPlay: "First Piano"),
    Mode(modeVal: "2", pianoPlay: "Second Piano"),
    Mode(modeVal: "3", pianoPlay: "Both")
  ];


  static List<Song> getSongs() {
    return [
      Song(songName: "Miniature Concerto", composer: "Alec Rowley!!!!"),
      Song(songName: "Concerto in A minor", composer: "Edvard Grieg"),
      Song(songName: "Concerto in C major", composer: "Antonio Vivaldi"),
      Song(songName: "Concerto in D major", composer: "Bach"),
      Song(songName: "Concerto in G major", composer: "Wolfgang Amadeus Mozart"),
    ];
  }
  Song({required this.songName, required this.composer});
}



