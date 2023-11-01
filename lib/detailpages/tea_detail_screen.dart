import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cart.dart';

class TeaDetailScreen extends StatefulWidget {
  TeaDetailScreen({this.kahveID});
  final String? kahveID;
  @override
  State<TeaDetailScreen> createState() => _TeaDetailScreenState();
}

class _TeaDetailScreenState extends State<TeaDetailScreen> {
  bool loading = false;
  bool isSmallPressed = false;
  bool isMediumPressed = false;
  bool isBigPressed = false;
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
        .collection("Bitki_Caylari")
        .doc(widget.kahveID)
        .get();

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 141, 130, 1).withOpacity(.99),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(12, 97, 86, 1),
        title: Text(
          "Çay ve Bitki Çayları",
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.mugSaucer),
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
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 50,
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
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(58, 141, 130, 1)
                                          .withOpacity(.99),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Küçük Boy Fiyat : ${data["smallsize"]} \$',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Orta Boy Fiyat : ${data["mediumsize"]} \$',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Büyük Boy Fiyat : ${data["bigsize"]} \$',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 170,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(58, 141, 130, 1)
                                          .withOpacity(.99),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'İçindekiler: ${data["desc"]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Kalori Değeri: ${data["calorie"]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 100,
                      child: Stack(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isSmallPressed = !isSmallPressed;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSmallPressed
                                        ? Color.fromRGBO(78, 143, 134, 1)
                                            .withOpacity(.99)
                                        : mainColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    primary: mainColor,
                                  ),
                                  child: Text('Küçük Boy'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isMediumPressed = !isMediumPressed;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isMediumPressed
                                        ? Color.fromRGBO(78, 143, 134, 1)
                                            .withOpacity(.99)
                                        : mainColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    primary: mainColor,
                                  ),
                                  child: Text('Orta Boy'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isBigPressed = !isBigPressed;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isBigPressed
                                        ? Color.fromRGBO(78, 143, 134, 1)
                                            .withOpacity(.99)
                                        : mainColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    primary: mainColor,
                                  ),
                                  child: Text('Büyük Boy'),
                                ),
                              ]),
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
                                    horizontal: 60, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
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
