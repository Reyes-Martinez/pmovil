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
            _PosterAndTitle(
              image: movie.fullPosterImg,
              title: movie.title,
              votes: movie.voteCount,
              originalTitle: movie.originalTitle,
              movieHeroId: movie.heroId!,
              id: movie.id,
              isFavorite: movie.isFavorite,
            ),
            const SizedBox(
              height: 20,
            ),
            _Overview(
              overview: movie.overview,
            ),
            CastingCard(moveId: movie.id),
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
  final int votes;
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(children: [
            Hero(
              tag: movieHeroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(image),
                  height: 150,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width - 170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    originalTitle,
                    style: textTheme.subtitle1,
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
                                  size: 30,
                                )),
                      const Text(
                        "Add favorite",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 30),
                      Text(
                        "Votes $votes",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;

  const _Overview({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(overview,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1));
  }
}
