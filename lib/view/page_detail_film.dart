import 'package:flutter/material.dart';
import '../model/detail_film.dart';
import '../controller/api_data_source.dart';

class PageDetailFilms extends StatefulWidget {
  final String imdbid;
  const PageDetailFilms({Key? key, required this.imdbid}) : super(key: key);

  @override
  State<PageDetailFilms> createState() => _PageDetailFilmsState();
}

class _PageDetailFilmsState extends State<PageDetailFilms> {
  FilmDetail? filmDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return FutureBuilder(
      future: ApiDataSource.instance.loadDetailFilm(widget.imdbid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          // Jika data ada error maka akan ditampilkan hasil error
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
          FilmDetail filmDetail = FilmDetail.fromJson(snapshot.data);
          return _buildItemUsers(filmDetail);
        }
        return _buildLoadingSection();
      },
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

  Widget _buildItemUsers(FilmDetail filmDetail) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(15),
          width: 320,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Image.network(
                  '${filmDetail.poster}',
                  width: 150,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  '${filmDetail.title}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Date Released:\n ${filmDetail.released}",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Genre:\n ${filmDetail.genre}",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Director:\n ${filmDetail.director}",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Actor:\n ${filmDetail.actors}",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Plot:\n ${filmDetail.plot}",
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
