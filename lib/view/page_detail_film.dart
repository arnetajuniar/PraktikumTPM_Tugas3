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

  // Widget _buildSuccessSection(FilmDetail filmModel) {
  //   return ListView.builder(
  //     itemCount: filmModel.ratings!.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _buildItemUsers(filmModel.ratings![index]);
  //     },
  //   );
  // }

  Widget _buildItemUsers(FilmDetail filmDetail) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Image.network('${filmDetail.poster}'),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${filmDetail.title}'),
            Text('${filmDetail.released}'),
            Text('${filmDetail.genre}'),
            Text('${filmDetail.director}'),
            Text('${filmDetail.actors}'),
            Text('${filmDetail.plot}')
          ],
        ),
      ],
    );
  }
}
