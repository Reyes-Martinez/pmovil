import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:practica2/models/models.dart';
import 'package:practica2/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/movies_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            id: movie.id,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Stack(
              children: [
                Hero(
                  tag: movie.id,
                  child: FadeInImage(
                    placeholder: const AssetImage("assets/no-image.jpg"),
                    image: NetworkImage(movie.fullPosterImg),
                  ),
                ),
                Column(
                  children: [
                    _PosterAndTitle(
                      image: movie.fullPosterImg,
                      title: movie.title,
                      votes: movie.voteAverage,
                      originalTitle: movie.originalTitle,
                      movieHeroId: movie.heroId!,
                      id: movie.id,
                      isFavorite: movie.isFavorite,
                    ),
                    _Overview(
                      overview: movie.overview,
                    ),
                    CastingCard(moveId: movie.id),
                  ],
                ),
              ],
            ),
          ])),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final int id;
  const _CustomAppBar({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: VideoCard(movieId: id),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String title;
  final String image;
  final String originalTitle;
  final double votes;
  final String movieHeroId;
  final int id;
  final bool isFavorite;
  const _PosterAndTitle(
      {Key? key,
      required this.title,
      required this.image,
      required this.votes,
      required this.originalTitle,
      required this.movieHeroId,
      required this.id,
      required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Material(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      color: Colors.black.withOpacity(.5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 85),
        child: Column(
          children: [
            Row(children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 170),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: textTheme.headline5!.fontSize,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              if (isFavorite == false) {
                                await moviesProvider
                                    .newFavoriteMovie(id)
                                    .then((value) {
                                  final snackBar = SnackBar(
                                      content: Text(
                                          'La pelicula $title se agrego a favoritos'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                });
                              } else {
                                await moviesProvider
                                    .removeFavoriteMovie(id)
                                    .then((value) {
                                  final snackBar = SnackBar(
                                      content: Text(
                                          'La pelicula $title se elimino de favoritos'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                });
                              }
                            },
                            icon: isFavorite == true
                                ? const Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                        const Text(
                          "Add favorite",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                    RatingStars(
                      value: votes,
                      maxValue: 10,
                    )
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;

  const _Overview({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(.5),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(overview,
              textAlign: TextAlign.center,
              maxLines: 9,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
                  color: Colors.white))),
    );
  }
}
