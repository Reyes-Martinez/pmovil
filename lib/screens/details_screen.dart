import 'package:flutter/material.dart';
import 'package:practica2/models/models.dart';
import 'package:practica2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.backdropPath);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            image: movie.fullBackdropImg,
            title: movie.title,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(
              image: movie.fullPosterImg,
              title: movie.title,
              votes: movie.voteCount,
              originalTitle: movie.originalTitle,
              movieHeroId: movie.heroId!,
            ),
            _Overview(
              overview: movie.overview,
            ),
            CastingCrad(moveId: movie.id)
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;
  final String image;
  const _CustomAppBar({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            )),
        background: FadeInImage(
          placeholder: const AssetImage("assets/loading.gif"),
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
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
  const _PosterAndTitle(
      {Key? key,
      required this.title,
      required this.image,
      required this.votes,
      required this.originalTitle,
      required this.movieHeroId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
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
        const SizedBox(
          width: 20,
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
                  const Icon(
                    Icons.star_border_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
                  Text(
                    "$votes",
                    style: textTheme.caption,
                  )
                ],
              )
            ],
          ),
        )
      ]),
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
