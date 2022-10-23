import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:practica2/provider/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      currentIndex: currentIndex,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_rounded), label: "Popular Movies"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: "Favorite Movies")
      ],
    );
  }
}
