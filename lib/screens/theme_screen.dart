import 'package:flutter/material.dart';
import 'package:practica2/provider/theme_provider.dart';
import 'package:practica2/settings/styles_settings.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                print('dia');
                tema.setthemeData(temaDia());
              },
              icon: Icon(Icons.brightness_1),
              label: Text('Tema de Día'),
            ),
            TextButton.icon(
              onPressed: () {
                print('noche');
                tema.setthemeData(temaNoche());
              },
              icon: Icon(Icons.dark_mode),
              label: Text('Tema de Noche'),
            ),
            TextButton.icon(
              onPressed: () {
                print('calido');
                tema.setthemeData(temaCalido());
              },
              icon: Icon(Icons.hot_tub_sharp),
              label: Text('Tema de Día'),
            ),
          ],
        ),
      ),
    );
  }
}
