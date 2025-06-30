import 'package:flutter/material.dart';
import 'pages/Landingpage.dart';
import 'pages/OrderNow.dart';
import 'pages/contactus.dart';
import 'pages/notifications.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LomiHub',
      debugShowCheckedModeBanner: false,
      initialRoute: '/landingpage',
      routes: {
        '/landingpage': (context) => const Landingpage(),
        '/contactus': (context) => const ContactUs(),
        '/OrderNow': (context)   => const  Ordernow(),
        '/notifications': (context) => const Notifications(),
      },
    );
  }
}
