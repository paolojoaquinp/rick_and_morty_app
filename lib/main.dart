import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/home_page/views/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and morty app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Material App Bar'),
      //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   ),
      //   body: const Center(
      //     child: Text('Hello World'),
      //   ),
      // ),
      home: HomePage(),
    );
  }
}
