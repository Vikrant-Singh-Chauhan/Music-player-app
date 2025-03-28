import 'package:flutter/material.dart';

import 'musicpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Music Player app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MusicPage(),
    );
  }
}

// class AllSongs extends StatefulWidget {
//   const AllSongs({super.key});
//
//   @override
//   State<AllSongs> createState() => _AllSongsState();
// }
//
// class _AllSongsState extends State<AllSongs> {
//
// /*  List<Map<String , dynamic >> myAudio = [
//     {
//       "audio" : "path"
//      }
//   ] ; */
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Music player app'),
//         actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
//       ),
//       body: FutureBuilder<List<SongModel>>(
//           future: _audioQuery.querySongs(
//             sortType: null,
//             orderType: OrderType.ASC_OR_SMALLER,
//             uriType: UriType.EXTERNAL,
//             ignoreCase: true,
//           ),
//           builder: (context, item) {
//             if (item.data == null) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (item.data!.isEmpty) {
//               return Center(child: Text("No song yet"));
//             }
//             return ListView.builder(
//               itemBuilder: (context, index) => ListTile(
//                 leading: const Icon(Icons.music_note),
//                 title: Text(item.data![index].displayNameWOExt),
//                 subtitle: Text("${item.data!
//                 [index].artist}"),
//                 trailing: Icon(Icons.more_horiz),
//               ),
//               itemCount: 100,
//             );
//           }),
//     );
//   }
// }
