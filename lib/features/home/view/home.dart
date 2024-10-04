import 'package:flutter/material.dart';
import 'package:netflix_clone/features/home/view_model/home_view_model.dart';
import 'package:netflix_clone/features/search/view/search.dart';
import 'package:netflix_clone/widgets/custom_carousel.dart';
import 'package:netflix_clone/widgets/upcoming_movie_card_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.nowPlaying();
    homeViewModel.upcomingMovies();
    homeViewModel.topRated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display top rated TV series directly from view model if available
            if (homeViewModel.topRatedModel != null)
              CustomCarouselSlider(data: homeViewModel.topRatedModel!),
            const SizedBox(
              height: 20,
            ),
            // Display Now Playing Movies
            SizedBox(
              height: 220,
              child: UpcomingMovieCard(
                headlineText: 'Now Playing',
                movieModel: homeViewModel.nowPlayingModel,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Display Upcoming Movies
            SizedBox(
              height: 220,
              child: UpcomingMovieCard(
                headlineText: 'Upcoming Movies',
                movieModel: homeViewModel.upcomingModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
