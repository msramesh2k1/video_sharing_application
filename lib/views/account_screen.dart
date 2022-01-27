import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:action/views/video_thumbnail.dart' as tn;

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("John Doe",
            style: GoogleFonts.josefinSans(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("@JohnDoe",
                style: GoogleFonts.josefinSans(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Following",
                        style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("234",
                        style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
                Column(
                  children: [
                    Text("Fans",
                        style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("234k",
                        style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
                Column(
                  children: [
                    Text("Hearts",
                        style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("2345",
                        style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Text("Message",
                        style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  child: const Center(child: Icon(EvaIcons.personAddOutline)),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("videos")
                        .snapshots(),
                    builder: (context, snapshots) {
                      return GridView.builder(
                          itemCount: snapshots.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                height: 50,
                                width: 40,
                                child: tn.ThumbnailImage(
                                  videoUrl: snapshots.data!.docs[index]['url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          });
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
