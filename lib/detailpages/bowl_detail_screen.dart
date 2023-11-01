import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cart.dart';

class BowlDetailScreen extends StatefulWidget {
  BowlDetailScreen({this.kahveID});
  final String? kahveID;
  @override
  State<BowlDetailScreen> createState() => _BowlDetailScreenState();
}

class _BowlDetailScreenState extends State<BowlDetailScreen> {
  bool loading = false;
  bool isPressed = false;
  String? image;
  String? name;
  String? price;
  String? count;

  @override
  Widget build(BuildContext) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var streamFirestore = firestore
        .collection("Crep_Coffee")
        .doc("crep_coffe_menu")
        .collection("Bowllar")
        .doc(widget.kahveID)
        .get();

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 141, 130, 1).withOpacity(.99),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(12, 97, 86, 1),
        title: Text(
          "Bowllar",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.bowlFood),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: streamFirestore,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Firebase Hata");
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              image = data["image"].toString();
              name = data["name"].toString();
              price = data["mediumsize"].toString();

              return Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 65,
                          ),
                          child: Column(children: [
                            Container(
                              child: Image.network(
                                data["image"],
                                width: 200,
                                height: 200,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${data["name"]}',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(58, 141, 130, 1)
                                          .withOpacity(.99),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Açıklama: ${data["desc"]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(58, 141, 130, 1)
                                      .withOpacity(.99),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Kalori Değeri: ${data["calorie"]}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(58, 141, 130, 1)
                                      .withOpacity(.99),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Fiyat: ${data["mediumsize"]} \$',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 100,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                var firestoreCartAdd =
                                    firestore.collection("Cart").add({
                                  "image": image.toString(),
                                  "name": name.toString(),
                                  "price": price.toString(),
                                  "count": count.toString(),
                                });
                                setState(() {
                                  isPressed = !isPressed;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isPressed
                                    ? Color.fromRGBO(78, 143, 134, 1)
                                        .withOpacity(.99)
                                    : mainColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                primary: mainColor,
                              ),
                              child: Text('Satın al'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text("Liste Boş");
            }
          }
        },
      ),
    );
  }
}
