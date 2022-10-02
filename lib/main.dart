import 'package:flutter/material.dart';
import 'package:practica2/provider/poviders.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginFormProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
          routes: {
            "/dashboard": (BuildContext context) => const DashboardScreen(),
            "/login": (BuildContext context) => const LoginScreen(),
            "/task": (BuildContext context) => const TaskScreen(),
            "/tasklist": (BuildContext context) => const ListTaskScreen(),
            "/theme": (BuildContext context) => const ThemeScreen(),
            "/profile": (BuildContext context) => const ProfileScreen(),
          },
        ));
  }
}