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
                tema.setthemeData(temaDia());
              },
              icon: const Icon(Icons.sunny, color: Colors.grey),
              label: const Text('Tema de Día',
                  style: TextStyle(color: Colors.grey)),
            ),
            TextButton.icon(
              onPressed: () {
                tema.setthemeData(temaNoche());
              },
              icon: const Icon(Icons.mode_night_outlined, color: Colors.black),
              label: const Text('Tema de Noche',
                  style: TextStyle(color: Colors.black)),
            ),
            TextButton.icon(
              onPressed: () {
                tema.setthemeData(temaAzul());
              },
              icon: const Icon(Icons.water, color: Colors.blue),
              label: Text('Tema Azul',
                  style: TextStyle(color: Colors.blue.shade400)),
            ),
            TextButton.icon(
              onPressed: () {
                tema.setthemeData(temaVerde());
              },
              icon: const Icon(
                Icons.wb_twilight_sharp,
                color: Colors.green,
              ),
              label: Text(
                'Tema Verde',
                style: TextStyle(color: Colors.green.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
