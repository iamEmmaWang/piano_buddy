import 'package:assets_audio_player/assets_audio_player.dart';

//audio player will be accessible everywhere, only one instance available
//avoids having one instance per screen that may overlap with other versions
class MainPlayer
{
  static final AssetsAudioPlayer player = AssetsAudioPlayer();
  static bool isLoaded = false;
  static bool isPlaying = false;

  /// Loads a URL into the player. Automatically set to not autoplay.
  static void loadURL(String URL) async
  {
    isLoaded = false;
    player.setVolume(1);
    player.open(Audio.network(URL), autoStart: false).
    then((value) {
      print("AUDIO PLAYER LOADED");
      isLoaded = true;
    }).catchError((error) {
      print("COULD NOT LOAD PLAYER: " + error.toString());
    });
  }

  static void play()
  {
    isPlaying = true;
    player.play();
  }

  static void pause()
  {
    isPlaying = false;
    player.pause();
  }

  static void stop()
  {
    isPlaying = false;
    player.stop();
  }
}