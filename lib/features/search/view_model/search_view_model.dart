import 'package:flutter/material.dart';
import 'package:netflix_clone/features/search/repository/search_repository.dart';
import 'package:netflix_clone/models/search_model.dart';

class SearchViewModel extends ChangeNotifier {
  SearchRepository _repository = SearchRepository();

  SearchModel? searchModel;
  Future search({String? search}) async {
    await _repository.getSearchedMovie(search ?? "").then((value) {
      searchModel = value;
    });
  }
}
