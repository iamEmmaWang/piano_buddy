

/*
* This file is the model for Song
* Song so far will have songName, artist
* */
import 'Mode.dart';
class Song{
  String songName;
  String composer;
  List<Mode> modes;


  static List<Song> getSongs() {
    return [
      Song(songName: "Miniature Concerto", composer: "Alec Rowley!!!!", modes: [Mode(modeVal: "1", pianoPlay: "Piano 1", audioPath: "song_files/baby_shark.mp3"),
        Mode(modeVal: "2", pianoPlay: "Piano 2", audioPath: "song_files/baby_shark.mp3"),
        Mode(modeVal: "3", pianoPlay: "Both", audioPath: "")]
      ),
      Song(songName: "Concerto in A minor", composer: "Edvard Grieg", modes: [Mode(modeVal: "1", pianoPlay: "Piano 1", audioPath: "song_files/baby_shark.mp3"),
        Mode(modeVal: "2", pianoPlay: "Piano 2", audioPath: "song_files/baby_shark.mp3"),
        Mode(modeVal: "3", pianoPlay: "Both", audioPath: "")]),
      Song(songName: "Concerto in C major", composer: "Antonio Vivaldi", modes: [Mode(modeVal: "1", pianoPlay: "Piano 1", audioPath: "song_files/baby_shark.mp3"),
        Mode(modeVal: "2", pianoPlay: "Piano 2", audioPath: "song_files/baby_shark.mp3"),
        Mode(modeVal: "3", pianoPlay: "Both", audioPath: "song_files/emodam.mp3")]),
    ];
  }
  Song({required this.songName, required this.composer, required this.modes});
}



