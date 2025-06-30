import 'package:flutter/material.dart';
import 'pages/landingPage.dart';
import 'pages/OrderNow.dart';

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
      initialRoute: '/OrderNow',
      routes: {
        '/landingPage': (context) => const  LandingPage(),
        '/OrderNow': (context)   => const  OrderNow(),
      },
    );
  }
}
