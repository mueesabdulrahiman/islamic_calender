import 'package:calendar/providers/data.dart';
import 'package:calendar/screens/splash_screen.dart';
import 'package:calendar/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Data>(context, listen: false).setAndFetchdata(),
      builder: (context, data) =>
          data.connectionState == ConnectionState.waiting
              ? const SplashScreen()
              : const TabScreen(
                  0,
                ),
    );
  }
}
