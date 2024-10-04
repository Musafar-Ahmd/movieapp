import 'package:flutter/material.dart';
import 'package:netflix_clone/features/home/repository/home_repository.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/models/movie_recommendation_mode.dart';
import 'package:netflix_clone/models/tv_series_model.dart';

import '../../../models/movie_detail_model.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  MovieModel? upcomingModel;
  MovieModel? nowPlayingModel;
  TvSeriesModel? topRatedModel;
  MovieRecommendationsModel? recommendationsModel;
  MovieDetailModel? movieDetailModel;
  Future upcomingMovies() async {
    await _repository.getUpcomingMovies().then((value) {
      upcomingModel = value;
    });
    notifyListeners();
  }

  Future nowPlaying() async {
    await _repository.getNowPlayingMovies().then((value) {
      nowPlayingModel = value;
    });
    notifyListeners();
  }

  Future popularMovies() async {
    await _repository.getPopularMovies().then((value) {
      recommendationsModel = value;
    });
    notifyListeners();
  }

  Future topRated() async {
    await _repository.getTopRatedSeries().then((value) {
      topRatedModel = value;
    });
    notifyListeners();
  }

  Future movieDetail(id) async {
    await _repository.getMovieDetail(id).then((value) {
      movieDetailModel = value;
    });
    notifyListeners();
  }

  Future recommendedMovies(id) async {
    await _repository.getMovieRecommendations(id).then((value) {
      recommendationsModel = value;
    });
    notifyListeners();
  }
}
