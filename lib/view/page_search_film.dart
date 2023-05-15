// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'page_list_film.dart';

class PageSearchFilm extends StatefulWidget {
  const PageSearchFilm({Key? key}) : super(key: key);

  @override
  _PageSearchFilmState createState() => _PageSearchFilmState();
}

class _PageSearchFilmState extends State<PageSearchFilm> {
  final _controller = TextEditingController();
  String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Film"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(1),
                child: Container(
                  child: TextField(
                    selectionHeightStyle: BoxHeightStyle.max,
                    style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(fontSize: 15)),
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.nunitoSans(fontSize: 15.0),
                      hintText: "Enter film title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      filled: true,
                      icon: const Icon(
                        Icons.search,
                        size: 40.0,
                      ),
                    ),
                    controller: _controller,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.all(1),
              child: Container(
                  child: ElevatedButton(
                child: Text(
                  "Search",
                  style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                          fontStyle: FontStyle.normal, fontSize: 20.0)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PageListFilms(text: _controller.text);
                  }));
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
