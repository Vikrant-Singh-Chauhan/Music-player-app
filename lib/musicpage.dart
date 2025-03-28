import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false ;
 String songPath = "audio/AlanWalkerFaded.mp3";

 void songPlay() async{
   if(isPlaying){
   await  audioPlayer.pause();
   } else {
    await audioPlayer.play(AssetSource(songPath));

   }
 }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: ()  {
            songPlay();
            setState(() {
              isPlaying = !isPlaying ;
            });
            },
          child: isPlaying ?  Icon(Icons.pause) : Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
