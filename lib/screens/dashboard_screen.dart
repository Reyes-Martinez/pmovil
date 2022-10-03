import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/shared/preferences.dart';
import 'package:provider/provider.dart';
import 'package:practica2/provider/poviders.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    if (profile.userDAO.email == "") {
      profile.cargarUser();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("DashboardScreen"),
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Theme.of(context)
                  .primaryColor //This will change the drawer background to blue.
              //other styles
              ),
          child: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    profile.userDAO.fullName != ""
                        ? profile.userDAO.fullName.toString()
                        : 'set name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(profile.userDAO.email.toString()),
                  currentAccountPicture: Hero(
                    tag: "hero",
                    child: CircleAvatar(
                      backgroundImage: profile.userDAO.image != ""
                          ? Image.file(
                              File("${profile.userDAO.image}"),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ).image
                          : const NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                        'https://p4.wallpaperbetter.com/wallpaper/243/559/623/space-circles-graphics-planet-wallpaper-preview.jpg'),
                    fit: BoxFit.cover,
                  )),
                ),
                ListTile(
                  leading: const Icon(Icons.document_scanner_sharp,
                      color: Colors.white),
                  title: const Text(
                    'Practica 1',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                ),
                ListTile(
                  leading: const Icon(Icons.checklist_rtl_outlined,
                      color: Colors.white),
                  title: const Text('Base de datos',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/tasklist');
                  },
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                ),
                ListTile(
                  leading: const Icon(Icons.checklist_rtl_outlined,
                      color: Colors.white),
                  title: const Text('Temas',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/theme');
                  },
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                ),
                ListTile(
                  leading: const Icon(Icons.movie, color: Colors.white),
                  title: const Text('Movies',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/movies');
                  },
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text('Cerrar sesion',
                      style: TextStyle(color: Colors.white)),
                  onTap: () async {
                    Preference.password = "";
                    Preference.user = "";
                    Preference.userFull = false;
                    profile.borrarUser();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
