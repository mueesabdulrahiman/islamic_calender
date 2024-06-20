import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: const Color.fromRGBO(126, 218, 87, 1),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Image.asset(
              "assets/images/white.png",
              fit: BoxFit.cover,
              height: 230,
              width: 230,
            ),
          ),
        ),
      ),
    );
  }
}
