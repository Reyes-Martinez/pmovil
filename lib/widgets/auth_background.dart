import 'dart:math';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [const _Background(), const _HeaderIcon(), child],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 120,
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
        0.2,
        0.8
      ],
          colors: [
        // Color.fromARGB(255, 46, 48, 95),
        Color.fromARGB(255, 12, 51, 228),
        Color.fromARGB(255, 1, 252, 252),
      ]));
  const _Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Gradiente
        Container(
          decoration: boxDecoration,
        ),
        const Positioned(top: -40, left: -70, child: _PinkBox())
      ],
    );
  }
}

class _PinkBox extends StatelessWidget {
  const _PinkBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4.5,
      child: Container(
          width: 360,
          height: 360,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 185, 0, 121),
                Color.fromARGB(255, 229, 151, 173)
              ]))),
    );
  }
}
