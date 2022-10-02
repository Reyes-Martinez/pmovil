import 'package:flutter/material.dart';
import 'package:practica2/provider/poviders.dart';
import 'package:practica2/settings/styles_settings.dart';
import 'package:practica2/shared/preferences.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                });
              },
              children: [
                Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome to the aplication',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/img1.png',
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Text(
                            'Ipsum nostrud veniam ullamco est cupidatat ullamco ut est. Quis id dolor ea quis culpa magna in anim est commodo nulla esse. Anim minim laborum exercitation dolore aliqua pariatur commodo et Lorem. Quis voluptate irure elit cupidatat Lorem laborum incididunt do velit id. Voluptate duis id est aliqua duis laboris incididunt occaecat amet anim aliquip do. Pariatur voluptate reprehenderit exercitation aute nisi enim non.',
                          ),
                        ),
                        const SizedBox(height: 40),
                        Image.asset(
                          'assets/arrow.png',
                          fit: BoxFit.cover,
                          width: 60,
                        ),
                        const Text('Tap on next button')
                      ],
                    )),
                Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Selected theme',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/theme.png',
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                        const SizedBox(height: 14),
                        Column(
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
                        const SizedBox(height: 40),
                        Image.asset(
                          'assets/arrow.png',
                          fit: BoxFit.cover,
                          width: 60,
                        ),
                        const Text('Tap on next button')
                      ],
                    )),
                Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Etid your profile',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 14),
                        Image.asset(
                          'assets/profile.png',
                          fit: BoxFit.cover,
                          width: 240,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Text(
                              'You can edit your profile after you are lgin'),
                        ),
                        const SizedBox(height: 40),
                      ],
                    )),
              ]),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                onPressed: () {
                  Preference.showOnboardin = false;
                  Navigator.pushNamed(context, '/login');
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(double.infinity, 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                ),
                child: const Text('Get Satarted'),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Theme.of(context).primaryColor,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text(
                        'SKIP',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const WormEffect(
                            spacing: 16,
                            dotColor: Colors.black26,
                            activeDotColor: Colors.white),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                      child: const Text('NEXT',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                    ),
                  ],
                ),
              ));
  }
}

class _Sider extends StatelessWidget {
  const _Sider({
    Key? key,
    required this.titel,
    required this.content,
    this.image,
    required this.color,
    this.buttons,
  }) : super(key: key);
  final String titel;
  final String content;
  final String? image;
  final Color? color;
  final Widget? buttons;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titel),
          ],
        ));
  }
}
