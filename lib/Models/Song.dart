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

