import 'dart:io';
import 'dart:math';

import 'package:action/views/account_screen.dart';
import 'package:action/views/search_page.dart';
import 'package:action/views/video_thumbnail.dart' as tn;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoPage extends StatefulWidget {
  final String url;

  const VideoPage({Key? key, required this.url}) : super(key: key);
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        _controller!.play();
        _controller!.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _controller!.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller!.value.size.width,
                      height: _controller!.value.size.height,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                )
              : Container(color: Colors.black),
          Positioned(
            bottom: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    EvaIcons.homeOutline,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SearchPage()));
                    },
                    child: const Icon(
                      EvaIcons.search,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () async {},
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                  const Icon(
                    EvaIcons.messageSquareOutline,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AccountPage()));
                    },
                    child: const Icon(
                      EvaIcons.personOutline,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 50,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Following   /   ",
                        style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                    Text("For You",
                        style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                  ],
                ),
              )),
          Positioned(
              bottom: 100,
              left: 20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.music_note,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Go Banaza | Akon",
                        style: GoogleFonts.aBeeZee(
                          color: Colors.white70,
                          fontSize: 17,
                        )),
                  ],
                ),
              )),
          Positioned(
              bottom: 150,
              left: 20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                          "Party your mind in stuff times and make go banaza",
                          style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ),
                  ],
                ),
              )),
          Positioned(
              bottom: 200,
              left: 20,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      child: Text("@induleka",
                          style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ),
                  ],
                ),
              )),
          Positioned(
            right: 20,
            bottom: 6,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.white,
                  ),
                  Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                    size: 30,
                  ),
                  Icon(
                    Icons.message,
                    size: 30,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.share,
                    size: 30,
                    color: Colors.white,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 23,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
