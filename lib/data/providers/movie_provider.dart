import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_movies/configs/app_keys.dart';
import 'package:flutter_movies/data/dio_client.dart';
import 'package:flutter_movies/data/models/movies.dart';
import 'package:flutter_movies/data/models/upcoming.dart';

import '../models/credits.dart';
import '../models/movie_detail.dart';

class MovieProvider extends DioClient {
  Future<Movies?> getPopular() async {
    try {
      final resp = await get(
        'https://api.themoviedb.org/3/movie/popular',
        queryParameters: {'api_key': AppKey.apiKey, 'language': AppKey.lang},
      );
      return Movies.fromJson(resp.data);
    } on DioError catch (e) {
      print('getPopular: ${e.message}');
    }
  }

  Future<Upcoming?> getUpcoming() async {
    try {
      final resp = await get(
        'https://api.themoviedb.org/3/movie/upcoming',
        queryParameters: {'api_key': AppKey.apiKey, 'language': AppKey.lang},
      );
      return Upcoming.fromJson(resp.data);
    } on DioError catch (e) {
      print('getUpcoming: ${e.message}');
    }
  }

  Future<MovieDetail?> getDetail(int id) async {
    try {
      final resp = await get(
        'https://api.themoviedb.org/3/movie/$id',
        queryParameters: {'api_key': AppKey.apiKey, 'language': AppKey.lang},
      );
      return MovieDetail.fromJson(resp.data);
    } on DioError catch (e) {
      print('getDetail: ${e.message}');
    }
  }

  Future<Credits?> getCredits(int id) async {
    try {
      final resp = await get(
        'https://api.themoviedb.org/3/movie/$id/credits',
        queryParameters: {'api_key': AppKey.apiKey, 'language': AppKey.lang},
      );
      return Credits.fromJson(resp.data);
    } on DioError catch (e) {
      print('getCredits: ${e.message}');
    }
  }

  Future<Movies?> searchMovies(String query) async {
    try {
      final resp = await get(
        'https://api.themoviedb.org/3/search/movie',
        queryParameters: {
          'api_key': AppKey.apiKey,
          'language': AppKey.lang,
          'query': query,
        },
      );
      return Movies.fromJson(resp.data);
    } on DioError catch (e) {
      log('searchMovies: $e');
    }
  }
}
