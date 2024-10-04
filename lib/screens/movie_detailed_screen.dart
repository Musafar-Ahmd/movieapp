import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/utils.dart';
import 'package:movieapp/features/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  fetchInitialData() {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.movieDetail(widget.movieId);
    homeViewModel.recommendedMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    var size = MediaQuery.of(context).size;

    // Check if data is available in HomeViewModel
    final movie = homeViewModel.movieDetailModel;
    final movieRecommendations = homeViewModel.recommendationsModel;

    if (movie == null) {
      // If movie details are not loaded yet, show a loading indicator or a blank widget
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    String genresText = movie.genres.map((genre) => genre.name).join(', ');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "$imageUrl${movie.posterPath}"),
                          fit: BoxFit.cover)),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        movie.releaseDate.year.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        genresText,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    movie.overview,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (movieRecommendations != null && movieRecommendations.results.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "More like this",
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: movieRecommendations.results.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.5 / 2,
                    ),
                    itemBuilder: (context, index) {
                      final recommendation = movieRecommendations.results[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(movieId: recommendation.id),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: "$imageUrl${recommendation.posterPath}",
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
