import 'package:flutter/material.dart';
import 'package:flutter_movies/data/models/movies.dart';
import 'package:flutter_movies/data/models/upcoming.dart';
import 'package:flutter_movies/data/providers/movie_provider.dart';

class HomeController extends ChangeNotifier {
  final MovieProvider movieProvider;

  HomeController({required this.movieProvider});

  bool popularLoading = true;
  Movies? popular;

  bool upcomingLoading = true;
  Upcoming? upcoming;

  Future loadPopular() async {
    popularLoading = true;
    popular = await movieProvider.getPopular();
    popularLoading = false;
    notifyListeners();
  }

  Future loadUpcoming() async {
    upcomingLoading = true;
    upcoming = await movieProvider.getUpcoming();
    upcomingLoading = false;
    notifyListeners();
  }
}
