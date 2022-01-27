import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Icon(EvaIcons.searchOutline),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ))),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          height: 45,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
        ),
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Populor Creators",
                  style: GoogleFonts.josefinSans(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .snapshots(),
                    builder: (context, snapshots) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(snapshots
                                                  .data!.docs[index]["url"]),
                                              fit: BoxFit.cover)),
                                    ),
                                    Text(snapshots.data!.docs[index]["name"],
                                        style: GoogleFonts.josefinSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      color: Colors.black,
                                      child: Center(
                                        child: Text("Follow",
                                            style: GoogleFonts.josefinSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                                height: 500,
                                color: Colors.white,
                                width: 120,
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
