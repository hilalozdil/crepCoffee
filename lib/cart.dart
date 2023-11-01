import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepages/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var usersStream = FirebaseFirestore.instance.collection('Cart').snapshots();
  double totalPrice = 0.0;

  void _incrementProductCount(Map<String, dynamic> productData) {
    print("Incrementing product count for: ${productData['name']}");
    setState(() {
      productData['count'] = productData['count'] + 1;
      totalPrice += double.parse(productData['price']);
    });
  }

  void _decrementProductCount(Map<String, dynamic> productData) {
    setState(() {
      if (productData['count'] > 1) {
        productData['count'] = productData['count'] - 1;
        totalPrice -= double.parse(productData['price']);
      }
    });
  }

  void _removeProductFromCart(Map<String, dynamic> productData) {
    setState(() {
      double productPrice = double.parse(productData["price"]);
      int productCount = productData["count"];
      totalPrice -= productPrice * productCount;

      FirebaseFirestore.instance
          .collection('Cart')
          .doc(productData["id"])
          .delete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 141, 130, 1).withOpacity(.99),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(12, 97, 86, 1),
        title: Text('Sepetim'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    double productPrice = double.parse(data["price"]);
                    totalPrice += productPrice;
                    return Container(
                      padding: EdgeInsetsDirectional.symmetric(
                          vertical: 30.0, horizontal: 16.0),
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: mainColor,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100.0,
                            child: Image.network(data["image"].toString()),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    data["name"].toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                    style: TextStyle(color: Colors.white),
                                    '${data["price"]}\$'),
                              ],
                            ),
                          ),
                          SizedBox(width: 30),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.remove),
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _decrementProductCount(data);
                                    });
                                  }),
                              Text(
                                '${data["count"]}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              IconButton(
                                  icon: Icon(Icons.add),
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _incrementProductCount(data);
                                    });
                                  }),
                              IconButton(
                                color: Colors.white,
                                icon: Icon(FontAwesomeIcons.trash),
                                iconSize: 20,
                                onPressed: () {
                                  _removeProductFromCart(data);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: mainColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Toplam Fiyat:',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        ' ${totalPrice.toStringAsFixed(2)}\$',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(58, 141, 130, 1).withOpacity(.99),
                    ),
                    height: 50,
                    width: 400,
                    child: Column(children: [
                      SizedBox(height: 20),
                      Text(
                          style: TextStyle(color: Colors.white),
                          'Sepeti Onayla')
                    ]),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
