import 'package:flutter/material.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/search_screen.dart'; // You need to create this
import 'package:final_project/screens/collection_screen.dart'; // You need to create this

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Application',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(), // Implement SearchScreen
        '/collection': (context) =>
            const CollectionScreen(), // Implement CollectionScreen
      },
    );
  }
}
