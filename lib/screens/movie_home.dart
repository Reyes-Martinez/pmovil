import 'package:flutter/material.dart';
import 'package:practica2/screens/favorite_movie_screen.dart';
import 'package:provider/provider.dart';

import '../provider/ui_provider.dart';
import '../widgets/custom_navigatorbar.dart';
import 'movies_screen.dart';

class MovieHomeScreen extends StatelessWidget {
  const MovieHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Movie Screen"),
      ),
      body: const _HomeScrennBody(),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _HomeScrennBody extends StatelessWidget {
  const _HomeScrennBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return const MovieScreen();
      case 1:
        return const FavoriteMovieScreen();
      default:
        return const MovieScreen();
    }
  }
}
