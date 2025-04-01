import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
  bool isSuffled = false;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String currentSong = "1";
  Random random = Random();

  void songPlay() async {
    String songPath = song[currentSong]!;
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(AssetSource(songPath));
    }
  }

  void nextSong() {
    setState(() {
      if (isSuffled) {
        int randomIndex = random.nextInt(song.length) + 1;
        currentSong = randomIndex.toString();
      } else {
        int next = int.parse(currentSong) + 1;
        if (next > song.length) next = 1;
        currentSong = next.toString();
      }
      songPlay();
    });
  }

  void previousSong() {
    setState(() {
      if (isSuffled) {
        int randomIndex = random.nextInt(song.length) + 1;
        currentSong = randomIndex.toString();
      } else {
        int previous = int.parse(currentSong) - 1;
        previous = song.length;
        currentSong = previous.toString();
      }
      songPlay();
    });
  }

  void toggleSuffled() {
    setState(() {
      isSuffled = !isSuffled;
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

  String formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800,
              Colors.deepPurple.shade200,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Album Art Placeholder
           /*   Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple.shade600,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/music_placeholder.png'), // Add your own image
                    fit: BoxFit.cover,
                  ),
                ),
              ),*/
              Lottie.asset("assets/animation/Animation - 1743534124240.json"),
              SizedBox(height: 30),
              // Song Title
              Text(
                song[currentSong]!.split('/').last.replaceAll('.mp3', ''),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              // Artist Name (placeholder)
              Text(
                "Artist Name",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),
              // Progress Bar
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white54,
                  thumbColor: Colors.white,
                  overlayColor: Colors.white30,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 14),
                ),
                child: Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) {
                    audioPlayer.seek(Duration(seconds: value.toInt()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(position),
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      formatDuration(duration),
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Shuffle Button
                  IconButton(
                    onPressed: toggleSuffled,
                    iconSize: 26,  // Reduced from 30
                    icon: Icon(
                      Icons.shuffle,
                      color: isSuffled ? Colors.white : Colors.white70,
                    ),
                  ),
                  SizedBox(width: 12),  // Reduced from 20

                  // Previous Button
                  IconButton(
                    onPressed: previousSong,
                    iconSize: 32,  // Reduced from 40
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),  // Reduced from 20

                  // Play/Pause Button
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 26,  // Reduced from 30
                      backgroundColor: Colors.white,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          songPlay();
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.deepPurple,
                          size: 28,  // Reduced from 36
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),  // Reduced from 20

                  // Next Button
                  IconButton(
                    onPressed: nextSong,
                    iconSize: 32,  // Reduced from 40
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),  // Reduced from 20

                  // Repeat Button
                  IconButton(
                    onPressed: () {},
                    iconSize: 26,  // Reduced from 30
                    icon: Icon(
                      Icons.repeat,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}