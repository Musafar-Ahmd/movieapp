import 'package:flutter/material.dart';
import 'package:movieapp/common/utils.dart';
import 'package:movieapp/screens/movie_detailed_screen.dart';

import '../features/home/model/movie_model.dart';

class UpcomingMovieCard extends StatelessWidget {
  final MovieModel? movieModel;
  final String headlineText;

  const UpcomingMovieCard({
    super.key,
    required this.movieModel,
    required this.headlineText,
  });

  @override
  Widget build(BuildContext context) {
    var data = movieModel?.results;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headlineText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movieId: data?[index].id ?? 0,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      '$imageUrl${data?[index].posterPath ?? ""}',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
