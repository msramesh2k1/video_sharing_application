import 'package:action/constants/colour.dart';
import 'package:action/views/video_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'https://player.vimeo.com/external/390169311.hd.mp4?s=2339bc0140b3be620ba72731b6ff775e8682e938&profile_id=173&oauth2_token_id=57447761')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: backgroundcolour,
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("videos").snapshots(),
              builder: (context, snapshots) {
                return PageView.builder(
                    itemCount: snapshots.data!.docs.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (snapshots.data!.size == 0) {
                        return const CircularProgressIndicator();
                      } else {
                        return VideoPage(
                          url: snapshots.data!.docs[index]['url'],
                        );
                      }
                    });
              })),
    );
  }
}
