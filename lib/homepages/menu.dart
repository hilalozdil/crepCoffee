import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/homepages/bowl_screen.dart';
import 'package:flutter_application_1/homepages/bread_screen.dart';
import 'package:flutter_application_1/homepages/cake_screen.dart';
import 'package:flutter_application_1/homepages/fresh_screen.dart';
import 'package:flutter_application_1/homepages/hotcof_screen.dart';
import 'package:flutter_application_1/homepages/coldcof_screen.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/homepages/milk_screen.dart';
import 'package:flutter_application_1/homepages/tea_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/profile.dart';

class Product {
  int? id;
  String? Name;
  String? photo;
  String? route;

  Product(String name, int price, String photo, String route) {
    this!.Name = name;
    this!.photo = photo;
    this!.route = route;
  }

  Product.withId(int id, name, int grade, String photo, String route) {
    this.id = id;
    this.Name = name;
    this.photo = photo;
    this.route = route;
  }
}

void main() => runApp(Menu());

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/hotcof': (context) => HotcofScreen(),
        '/coldcof': (context) => ColdcofScreen(),
        '/tea': (context) => TeaScreen(),
        '/fresh': (context) => FreshScreen(),
        '/milk': (context) => MilkshakeScreen(),
        '/bowl': (context) => BowlScreen(),
        '/bread': (context) => BreadScreen(),
        '/cake': (context) => CakeScreen(),
      },
      theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(12, 97, 86, 1)),
    );
  }
}

class HomeScreen extends StatelessWidget {
  List<Product> products = [
    Product.withId(
        1,
        "Sıcak Kahveler",
        95,
        "http://coffeemode.com.tr/wp-content/uploads/2016/03/sicak-k.jpg",
        "/hotcof"),
    Product.withId(
        2,
        "Soğuk Kahveler",
        55,
        "https://cdn.yemek.com/uploads/2020/05/evde-latte-yapimi-2.jpg",
        "/coldcof"),
    Product.withId(
        3,
        "Bitki Çayları",
        75,
        "https://cdn.pixabay.com/photo/2015/07/02/20/37/cup-829527_1280.jpg",
        "/tea"),
    Product.withId(
        4,
        "Fresh İçecekler",
        60,
        "https://cdn.yemek.com/uploads/2015/06/cilekli-limonata-tarifi.jpg",
        "/fresh"),
    Product.withId(
        5,
        "Milkshakeler",
        88,
        "https://i.pinimg.com/564x/f3/a4/59/f3a45970759c82344ffd7aeb747c88a4.jpg",
        "/milk"),
    Product.withId(
        6,
        "Bowllar",
        88,
        "https://i.pinimg.com/564x/18/26/9a/18269afcb1c55bbf965653cd7ed35c1b.jpg",
        "/bowl"),
    Product.withId(
        7,
        "Kahvaltılıklar",
        88,
        "https://i.pinimg.com/564x/ff/f2/2a/fff22a1fbb523d269c54860eb57e1021.jpg",
        "/bread"),
    Product.withId(
        8,
        "Pasta ve Kekler",
        88,
        "https://i.pinimg.com/736x/3c/85/32/3c8532509b51f5fd9c5824314f300071.jpg",
        "/cake"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(12, 97, 86, 1),
          title: Text(
            "Crep Coffee Menü",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_bag),
            ),
          ],
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Color.fromRGBO(58, 141, 130, 1).withOpacity(.75),
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              String route = products[index].route!;
              Navigator.pushNamed(context, route, arguments: products[index]);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(products[index].photo!),
                  ),
                  SizedBox(width: 46.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          products[index].Name!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.0),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
