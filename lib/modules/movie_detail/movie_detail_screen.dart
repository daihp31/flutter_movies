import 'package:flutter/material.dart';
import 'package:flutter_movies/data/models/movies.dart';
import 'package:flutter_movies/modules/movie_detail/movie_detail_controller.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String name = 'movie-detail';

  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailController get controller => context.read<MovieDetailController>();
  @override
  void initState() {
    super.initState();
    //
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff21232A),
      appBar: AppBar(
        backgroundColor: const Color(0xff21232A),
        title: Text(widget.movie.originalTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500/${widget.movie.backdropPath}',
              width: double.infinity,
            ),
            Text(
              widget.movie.originalTitle,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
