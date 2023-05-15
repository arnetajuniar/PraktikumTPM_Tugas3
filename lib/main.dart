import 'package:flutter/material.dart';
import 'package:praktikum_pertemuan_8/view/page_search_film.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMBD Film',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PageSearchFilm(),
    );
  }
}
