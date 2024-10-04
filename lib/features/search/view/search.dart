import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/utils.dart';
import 'package:movieapp/features/home/view_model/home_view_model.dart';
import 'package:movieapp/features/search/view_model/search_view_model.dart';
import 'package:movieapp/screens/movie_detailed_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.popularMovies(); // Fetch popular movies initially
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);
        final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CupertinoSearchTextField(
                controller: searchController,
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    viewModel.search(search: searchController.text);
                  }
                },
              ),
              searchController.text.isEmpty
                  ? viewModel.searchModel == null
                      ? const Center(child: CircularProgressIndicator())
                      : _buildPopularMoviesList(homeViewModel)
                  : viewModel.searchModel == null
                      ? const SizedBox.shrink()
                      : _buildSearchResultsGrid(viewModel)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularMoviesList(HomeViewModel viewModel) {
    var data = viewModel.topRatedModel?.results ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Top Searches",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        movieId: data[index].id,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        '$imageUrl${data[index].posterPath}',
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(width: 20),
                      Text(data[index].name),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchResultsGrid(SearchViewModel viewModel) {
    var results = viewModel.searchModel?.results ?? [];
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 5,
        childAspectRatio: 1.2 / 2,
      ),
      itemBuilder: (context, index) {
        var result = results[index];
        return result.backdropPath == null
            ? Column(
                children: [
                  Image.asset(
                    "assets/netflix.png",
                    height: 170,
                  ),
                  Text(
                    result.title,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14),
                  )
                ],
              )
            : Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                            movieId: result.id,
                          ),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: '$imageUrl${result.backdropPath}',
                      height: 170,
                    ),
                  ),
                  Text(
                    result.title,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              );
      },
    );
  }
}
