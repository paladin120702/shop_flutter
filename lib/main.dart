import 'package:flutter/material.dart';
import 'package:shop/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        primaryColor: Colors.blue,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
