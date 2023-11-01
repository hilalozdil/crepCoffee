import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../detailpages/hotcof_detail_screen.dart';

class HotcofScreen extends StatefulWidget {
  @override
  _HotcofScreenState createState() => _HotcofScreenState();
}

class _HotcofScreenState extends State<HotcofScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var streamFirestore = firestore
        .collection("Crep_Coffee")
        .doc("crep_coffe_menu")
        .collection("Sicak_Kahveler")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          "Sıcak Kahveler",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: streamFirestore,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log("================= 1");
            return const Text("Firebase Hata");
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              log("================= 2");
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              log("================= 3");
              return listSicakKahveler(snapshot);
            } else {
              log("================= 4");
              return const Text("Liste Boş");
            }
          }
        },
      ),
    );
  }

  GridView listSicakKahveler(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      children: snapshot.data!.docs.map(
        (e) {
          Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotcofDetailScreen(
                      kahveID: e.id,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(58, 141, 130, 1).withOpacity(.75),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 105,
                        child: Image.network(data["image"]),
                      ),
                      Text(
                        data["name"],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
