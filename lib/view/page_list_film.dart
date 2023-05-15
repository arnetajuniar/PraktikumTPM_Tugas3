// ignore_for_file: avoid_unnecessary_containers

import 'package:praktikum_pertemuan_8/view/page_detail_film.dart';

import '../controller/api_data_source.dart';
import '../model/list_film.dart';
import 'package:flutter/material.dart';

class PageListFilms extends StatefulWidget {
  final String text;
  const PageListFilms({Key? key, required this.text}) : super(key: key);
  @override
  State<PageListFilms> createState() => _PageListFilmsState();
}

class _PageListFilmsState extends State<PageListFilms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Film"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadListFilm(widget.text),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            FilmList filmModel = FilmList.fromJson(snapshot.data);
            return _buildSuccessSection(filmModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return const Text("Error");
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(FilmList filmModel) {
    return ListView.builder(
      itemCount: filmModel.search!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(filmModel.search![index]);
      },
    );
  }

  Widget _buildItemUsers(Search film) {
    return InkWell(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const PageDetailFilms(imdbid: '');
          },
        ))
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Image.network(film.poster!),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(film.title!), Text(film.year!)],
            ),
          ],
        ),
      ),
    );
  }
}
