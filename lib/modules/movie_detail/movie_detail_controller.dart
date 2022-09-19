import 'package:flutter/cupertino.dart';
import 'package:flutter_movies/data/models/credits.dart';
import 'package:flutter_movies/data/models/movie_detail.dart';
import 'package:flutter_movies/data/providers/movie_provider.dart';

class MovieDetailController extends ChangeNotifier {
  final MovieProvider movieProvider;

  MovieDetailController({required this.movieProvider});

  bool detailLoading = true;
  MovieDetail? detail;

  bool creditsLoading = true;
  Credits? credits;

  /// tương tự như ở home_controller mn get detail bằng cách gọi movieProvider.getDetail(id) với id của moive
  Future loadDetail(int id) async {
    detailLoading = true;
    detail = await movieProvider.getDetail(id);
    detailLoading = false;
    notifyListeners();
  }

  Future loadCredits(int id) async {
    creditsLoading = true;
    credits = await movieProvider.getCredits(id);
    creditsLoading = false;
    notifyListeners();
  }
}
