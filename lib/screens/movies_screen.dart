import 'package:flutter/material.dart';
import 'package:practica2/provider/poviders.dart';
import 'package:practica2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          //Tarjetas principales
          CardSwiper(movies: moviesProvider.onDiplayMovies),
          //Slider de peliculas
          const SizedBox(height: 20),
          MovieSlider(
              movies: moviesProvider.popularMovies,
              title: "Populares",
              onNextPage: () => moviesProvider.getPopularMovies()),
        ],
      ),
    );
  }
}
