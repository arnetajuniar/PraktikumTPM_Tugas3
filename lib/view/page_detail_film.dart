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
          FilmDetail filmModel = FilmDetail.fromJson(snapshot.data);
          return _buildItemUsers(filmModel);
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

  // Widget _buildSuccessSection(FilmDetail filmModel) {
  //   return ListView.builder(
  //     itemCount: filmModel.ratings!.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _buildItemUsers(filmModel.ratings![index]);
  //     },
  //   );
  // }

  Widget _buildItemUsers(FilmDetail filmModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Image.network(filmModel.poster!),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(filmModel.title!),
            Text(filmModel.released!),
            Text(filmModel.genre!),
            Text(filmModel.director!),
            Text(filmModel.actors!),
            Text(filmModel.plot!)
          ],
        ),
      ],
    );
  }
}
