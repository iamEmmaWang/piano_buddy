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

Map<String, Song> songDictionary = {
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


