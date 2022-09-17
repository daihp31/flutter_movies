import 'package:flutter/cupertino.dart';
import 'package:flutter_movies/data/models/movie_detail.dart';
import 'package:flutter_movies/data/providers/movie_provider.dart';

class MovieDetailController extends ChangeNotifier {
  final MovieProvider movieProvider;

  MovieDetailController({required this.movieProvider});

  bool detailLoading = true;
  MovieDetail? detail;
}
