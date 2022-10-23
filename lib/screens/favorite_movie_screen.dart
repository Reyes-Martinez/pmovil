import 'package:flutter/material.dart';
import 'package:practica2/provider/poviders.dart';
import 'package:practica2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FavoriteMovieScreen extends StatelessWidget {
  const FavoriteMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return SingleChildScrollView(
      child: moviesProvider.lFavoriteMovies.isEmpty
          ? const Center(
              child: Text(
                'No tienes ninguna pelicula favorita!!',
                style: TextStyle(fontSize: 90),
              ),
            )
          : Column(
              children: [
                CardSwiper(movies: moviesProvider.lFavoriteMovies),
                const SizedBox(height: 20),
                MovieSlider(
                    movies: moviesProvider.lFavoriteMovies,
                    title: "Favoritas",
                    onNextPage: () => {}),
              ],
            ),
    );
  }
}
