import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../common/app_urls.dart';
import '../model/search_model.dart';

late String endPoint;

class SearchRepository {
  Future<SearchModel> getSearchedMovie(String searchText) async {
  endPoint = 'search/movie?query=$searchText';
  final url = '$AppUrls.baseUrl$endPoint';
  print(url);
  final response = await http.get(Uri.parse(url), headers: {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
  });
  log(response.statusCode.toString());
  if (response.statusCode == 200) {
    log('success');
    return SearchModel.fromJson(jsonDecode(response.body));
  }
  throw Exception('failed to load  search movie ');
}
}


