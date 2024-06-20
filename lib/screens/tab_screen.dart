import 'package:calendar/screens/add_event_scree.dart';
import 'package:calendar/screens/calender_screen.dart';
import 'package:calendar/screens/hadees_screen.dart';
import 'package:calendar/screens/profile_screen.dart';
import 'package:calendar/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class TabScreen extends StatefulWidget {
  final int index;
  const TabScreen(
    this.index, {super.key}
  );
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _index = 0;

 

  @override
  void initState() {
    _index = widget.index;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      CalenderScreen(),
      HadeesScreen(),
      AddEventScreen(
          //  widget.showNotification
          ),
      ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Settings.bgColour,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Islamic Calendar".toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: pages[_index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 10,
                activeColor: Colors.white,
                iconSize: 25,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey.shade800,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.book,
                    text: 'Hadees',
                  ),
                   GButton(
                    icon: Icons.event,
                    text: 'Add Event',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _index,
                onTabChange: (index) {
                  setState(() {
                    _index = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
