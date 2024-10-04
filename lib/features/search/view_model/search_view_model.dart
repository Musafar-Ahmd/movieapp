import 'package:flutter/material.dart';
import 'package:movieapp/features/search/model/search_model.dart';
import 'package:movieapp/features/search/repository/search_repository.dart';

class SearchViewModel extends ChangeNotifier {
  SearchRepository _repository = SearchRepository();

  SearchModel? searchModel;
  Future search({String? search}) async {
    await _repository.getSearchedMovie(search ?? "").then((value) {
      searchModel = value;
    });
  }
}
