import 'dart:convert';

import 'package:http/http.dart';

enum PianoPlay {first, second, both}

/// given a value of PianoPlay (primo, secondo, or both), returns a display string.
String pianoPlayString(PianoPlay p)
{
  switch (p)
  {
    case PianoPlay.first: return "1st Piano";
    case PianoPlay.second: return "2nd Piano";
    case PianoPlay.both: return "Both";
  }
}

class Mode {
  PianoPlay piano;
  String pdfLink;
  String audioLink;
  List<double> turnTimeStamps;

  Mode({required this.piano, required this.pdfLink, required this.audioLink, required this.turnTimeStamps});
}

class Song{
  String songName;
  String composer;
  List<Mode> modes;

  Song({required this.songName, required this.composer, required this.modes});

  /// Creates a song object automatically given the song name, composer, 3 PDF links, and 3 audio links.
  /// Links provided should be download URLs for the respective files.
  static Song fromLinks({required String songName, required String composer,
    required String primoPDF, required String primoAudio, required List<double> primoTimeStamps,
    required String secondoPDF, required String secondoAudio, required List<double> secondoTimeStamps,
    required String bothPDF, required String bothAudio, required List<double> bothTimeStamps,})
  {
    Song s = Song(songName: songName, composer: composer, modes: []);
    s.modes = [
      Mode(
        piano: PianoPlay.first,
        pdfLink: primoPDF,
        audioLink: primoAudio,
          turnTimeStamps: primoTimeStamps
      ),
      Mode(
        piano: PianoPlay.second,
        pdfLink: secondoPDF,
        audioLink: secondoAudio,
          turnTimeStamps: secondoTimeStamps
      ),
      Mode(
        piano: PianoPlay.both,
        pdfLink: bothPDF,
        audioLink: bothAudio,
          turnTimeStamps: bothTimeStamps
      ),
    ];
    return s;
  }
}

Future<void> getSongDictionary() async {
  songDictionary.clear();
  const String REQUEST_URL = "https://MasterSongList.bigphan.repl.co";
  var response = await get(Uri.parse(REQUEST_URL));
  var responseData = jsonDecode(response.body);
  responseData.forEach((songName, songData) {
    songDictionary[songName] = Song.fromLinks(
        songName: songName,
        composer: songData["composer"],
        primoPDF: songData["primo"]["pdf"],
        primoAudio: songData["primo"]["audio"],
        primoTimeStamps: List<double>.from(songData["primo"]["turnTimeStamps"]),
        secondoPDF: songData["secondo"]["pdf"],
        secondoAudio: songData["secondo"]["audio"],
        secondoTimeStamps: List<double>.from(songData["secondo"]["turnTimeStamps"]),
        bothPDF: songData["both"]["pdf"],
        bothAudio: songData["both"]["audio"],
        bothTimeStamps: List<double>.from(songData["both"]["turnTimeStamps"])
    );
  });
}

Map<String, Song> songDictionary = {};



