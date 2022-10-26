import 'package:flutter/material.dart';
import 'package:practica2/models/models.dart';
import 'package:practica2/provider/poviders.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {
  final int moveId;
  const CastingCard({Key? key, required this.moveId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(moveId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: double.infinity,
            height: 120,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final cast = snapshot.data!;
        return Material(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: Colors.black.withOpacity(.5),
          child: Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (_, index) => _CastCard(actor: cast[index]),
            ),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 105,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(actor.fullProfilePath),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 5,
          ),
          Text(
            actor.name,
            maxLines: 1,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
