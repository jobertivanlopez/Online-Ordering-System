import 'package:flutter/material.dart';
import 'pages/landingPage.dart';
import 'pages/OrderNow.dart';
import 'pages/contactus.dart';
import 'pages/notifications.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LomiHub',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/landingpage': (context) => const Landingpage(),
        '/contactus': (context) => const ContactUs(),
        '/OrderNow': (context)   => const  OrderNow(),
        '/notifications': (context) => const Notifications(),
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food Recommendations'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 100),

              Text(
                'You Might Also Like',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20),
              // Horizontal list of food items
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FoodItem(
                      image: 'assets/Dessert.png',
                      title: 'Graham',
                    ),
                    FoodItem(
                      image: 'assets/Pancit_Canton_Bihon_Guisado.png',
                      title: 'Bihon',
                    ),
                    FoodItem(
                      image: 'assets/sweet_and_spicy.png',
                      title: 'Sweet & Spicy',
                    ),
                    FoodItem(
                      image: 'assets/Spaghetti.png',
                      title: 'Spaghetti',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(10, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.5, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}



class FoodItem extends StatelessWidget {
  final String image;
  final String title;

  FoodItem({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Image.asset(image, width: 150, height: 150, fit: BoxFit.cover),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('Order Now'),
          ),
        ],
      ),
    );
  }
}