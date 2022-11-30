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

  Mode({required this.piano, required this.pdfLink, required this.audioLink});
}

class Song{
  String songName;
  String composer;
  List<Mode> modes;

  Song({required this.songName, required this.composer, required this.modes});

  /// Creates a song object automatically given the song name, composer, 3 PDF links, and 3 audio links.
  /// Links provided should be download URLs for the respective files.
  static Song fromLinks({required String songName, required String composer, required String primoPDF, required String primoAudio, required String secondoPDF, required String secondoAudio, required String bothPDF, required String bothAudio})
  {
    Song s = Song(songName: songName, composer: composer, modes: []);
    s.modes = [
      Mode(
        piano: PianoPlay.first,
        pdfLink: primoPDF,
        audioLink: primoAudio
      ),
      Mode(
        piano: PianoPlay.second,
        pdfLink: secondoPDF,
        audioLink: secondoAudio
      ),
      Mode(
        piano: PianoPlay.both,
        pdfLink: bothPDF,
        audioLink: bothAudio
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
        secondoPDF: songData["secondo"]["pdf"],
        secondoAudio: songData["secondo"]["audio"],
        bothPDF: songData["both"]["pdf"],
        bothAudio: songData["both"]["audio"]
    );
  });
}



Map<String, Song> songDictionary = {
  // "Miniature Concerto": Song.fromLinks(
  //     songName: "Miniature Concerto",
  //     composer: "Alec Rowley",
  //     primoPDF: "https://drive.google.com/uc?id=1y1lOgV3FdGBkGMOb89rojlEE6-3haj7g&export=download",
  //     primoAudio: "https://drive.google.com/uc?id=1l1kLEzVnTqyw_TJJD6j1Oe9__FlSq_XW&export=download",
  //     secondoPDF: "https://drive.google.com/uc?id=1y1lOgV3FdGBkGMOb89rojlEE6-3haj7g&export=download",
  //     secondoAudio: "https://drive.google.com/uc?id=1tpXEOTYT3KXYo1Rzc1572pv4bceqWLBQ&export=download",
  //     bothPDF: "https://drive.google.com/uc?id=1y1lOgV3FdGBkGMOb89rojlEE6-3haj7g&export=download",
  //     bothAudio: "https://drive.google.com/uc?id=1Kx70F8BoZJUNmhgRFRgHBpqth-3l9cof&export=download"
  // ),
  "Prelude Defaun": Song.fromLinks(
      songName: "Prelude Defaun",
      composer: "Debussy",
      primoPDF: "https://drive.google.com/uc?id=1fzJChP7ty48i-mPSyo9YvDUbhq5j8q55&export=download",
      primoAudio: "https://www.free-scores.com/MP3SUPT/gurlitt-cornelius-moderato-9646-183875.mp3",
      secondoPDF: "https://drive.google.com/uc?id=1fzJChP7ty48i-mPSyo9YvDUbhq5j8q55&export=download",
      secondoAudio: "https://drive.google.com/uc?id=1usOI5H2vkh95t6FjaTd_oMHmDwfe04ss&export=download",
      bothPDF: "https://drive.google.com/uc?id=1fzJChP7ty48i-mPSyo9YvDUbhq5j8q55&export=download",
      bothAudio: "https://drive.google.com/uc?id=1fq3lpvy4-of3ER1GAH8kwNUQy9SujxS8&export=download"
  ),
  "Moderato": Song.fromLinks(
      songName: "Moderato",
      composer: "Cornelius Gurlitt",
      primoPDF: "https://www.free-scores.com/PDF_EN/gurlitt-cornelius-moderato-183875.pdf",
      primoAudio: "https://www.free-scores.com/MP3SUPT/gurlitt-cornelius-moderato-9646-183875.mp3",
      secondoPDF: "https://www.free-scores.com/PDF_EN/gurlitt-cornelius-moderato-183875.pdf",
      secondoAudio: "https://www.free-scores.com/MP3SUPT/gurlitt-cornelius-moderato-2967-183875.mp3",
      bothPDF: "https://www.free-scores.com/PDF_EN/gurlitt-cornelius-moderato-183875.pdf",
      bothAudio: "https://www.free-scores.com/MP3T/gurlitt-cornelius-moderato-183875.mp3"
  ),
  "Rondino": Song.fromLinks(
      songName: "Rondino",
      composer: "Joseph Hadyn",
      primoPDF: "https://www.free-scores.com/PDFSUP_EN/haydn-joseph-rondino-primo-7237-181025.pdf",
      primoAudio: "https://www.free-scores.com/MP3SUPT/haydn-joseph-rondino-8534-181025.mp3",
      secondoPDF: "https://www.free-scores.com/PDFSUP_EN/haydn-joseph-rondino-secondo-6239-181025.pdf",
      secondoAudio: "https://www.free-scores.com/MP3SUPT/haydn-joseph-rondino-4007-181025.mp3",
      bothPDF: "https://www.free-scores.com/PDF_EN/haydn-joseph-rondino-181025-684.pdf",
      bothAudio: "https://www.free-scores.com/MP3T/haydn-joseph-rondino-181025-684.mp3"
  ),
  "Menuet": Song.fromLinks(
      songName: "Menuet",
      composer: "Amadeus Mozart",
      primoPDF: "https://www.free-scores.com/PDFSUP_EN/mozart-wolfgang-amadeus-menuet-primo-3218-180183.pdf",
      primoAudio: "https://www.free-scores.com/MP3SUPT/mozart-wolfgang-amadeus-menuet-3256-180183.mp3",
      secondoPDF: "https://www.free-scores.com/PDFSUP_EN/mozart-wolfgang-amadeus-menuet-secondo-3623-180183.pdf",
      secondoAudio: "https://www.free-scores.com/MP3SUPT/mozart-wolfgang-amadeus-menuet-950-180183.mp3",
      bothPDF: "https://www.free-scores.com/PDF_EN/mozart-wolfgang-amadeus-menuet-180183.pdf",
      bothAudio: "https://www.free-scores.com/MP3T/mozart-wolfgang-amadeus-menuet-180183.mp3"
  ),
};



