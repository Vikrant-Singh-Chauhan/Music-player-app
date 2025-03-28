import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final Map<String, String> song = {
    "1": "audio/AlanWalkerFaded.mp3",
    "2": "audio/JoTumMereHo.mp3",
    "3": "audio/ASLE.mp3",
    "4": "audio/Humdard.mp3",
    "5": "audio/Husn.mp3",
    "6": "audio/Kabhi_Kabhi_Aditi.mp3",
    "7": "audio/Mujhe_Peene_Do.mp3",
    "8": "audio/Uska_Hi_Banana.mp3",
  };
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String currentSong = "1";

  void songPlay() async {
    String songPath = song[currentSong]!;
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(AssetSource(songPath));
    }
  }

  void nextSong() {
    int next = int.parse(currentSong) + 1;
    if (next > song.length) {
      next = 1;
    }
    setState(() {
      currentSong = next.toString();
      songPlay();
    });
  }

  void previousSong() {
    int previous = int.parse(currentSong) - 1;
    if (previous < 1) {
      previous = song.length;
    }
    setState(() {
      currentSong = previous.toString();
      songPlay();
    });
  }

  @override
  void initState() {
    super.initState();

    audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });

    audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                song[currentSong]!.split('/').last,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: previousSong, icon: Icon(Icons.skip_previous)),
                  ElevatedButton(
                    onPressed: () {
                      songPlay();
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                    child: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  ),
                  IconButton(onPressed: nextSong, icon: Icon(Icons.skip_next)),
                ],
              ),
              SizedBox(height: 20),
              Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                thumbColor: Colors.blue,
                onChanged: (value) {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(_formatDuration(position)),
                  Text(_formatDuration(duration)),
                ],
              )
            ],
          )),
    );
  }
}
