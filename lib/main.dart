import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/search_screen.dart';
import 'package:final_project/screens/collection_screen.dart';
import 'package:final_project/utils/favorites_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MaterialApp(
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
          '/search': (context) => const SearchScreen(),
          '/collection': (context) => const CollectionScreen(),
        },
      ),
    );
  }
}
