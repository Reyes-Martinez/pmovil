import 'package:flutter/material.dart';
import 'package:practica2/provider/poviders.dart';
import 'package:practica2/provider/ui_provider.dart';
import 'package:practica2/screens/favorite_movie_screen.dart';
import 'package:practica2/screens/screens.dart';
import 'package:practica2/shared/preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ChangeNotifierProvider(create: (_) => TaskProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => MoviesProvider()),
      ChangeNotifierProvider(create: (_) => UiProvider()),
    ], child: const _APP());
  }
}

class _APP extends StatelessWidget {
  const _APP({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Practica 2',
      theme: tema.getthemeData(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/dashboard": (BuildContext context) => const DashboardScreen(),
        "/login": (BuildContext context) => const LoginScreen(),
        "/task": (BuildContext context) => const TaskScreen(),
        "/tasklist": (BuildContext context) => const ListTaskScreen(),
        "/theme": (BuildContext context) => const ThemeScreen(),
        "/profile": (BuildContext context) => const ProfileScreen(),
        "/onboarding": (BuildContext context) => const OnboardingScreen(),
        "/movies": (BuildContext context) => const MovieHomeScreen(),
        "/details": (BuildContext context) => const DetailsScreen(),
        "/popularMovies": (BuildContext context) => const MovieScreen(),
        "/favoriteMovies": (BuildContext context) =>
            const FavoriteMovieScreen(),
      },
    );
  }
}
