import 'package:flutter/material.dart';
import 'package:practica2/provider/poviders.dart';
import 'package:practica2/search/search_delegate.dart';
import 'package:practica2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Peliculas en cines")),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(movies: moviesProvider.onDiplayMovies),
            //Slider de peliculas
            MovieSlider(
                movies: moviesProvider.popularMovies,
                title: "Populares",
                onNextPage: () => moviesProvider.getPopularMovies()),
            // MovieSlider(
            //     movies: moviesProvider.popularTvSeries,
            //     title: "Series",
            //     onNextPage: () => moviesProvider.getPopularTvSeries()),
          ],
        ),
      ),
    );
  }
}
