import 'package:calendar/providers/data.dart';
import 'package:calendar/widgets/calender_section.dart';
import 'package:calendar/widgets/events_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
     print('helloooo');
    return SingleChildScrollView(
      child: Consumer<Data>(
        builder: (context, data, child) => Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            if (data.calenderTopAd != null)
              const Column(
                children: [
                  // AdWidget(
                  //   // data.calenderTopAd["link"],
                  //   data.calenderTopAd?["image"],
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            CalenderSection(),
            EventsList(),
            if (data.calenderBottomAd != null)
             const  Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  // AdWidget(
                  //   // data.calenderBottomAd["link"],
                  //   data.calenderBottomAd?["image"],
                  // ),
                ],
              ),
           const  SizedBox(
              height: 8,
            ),
          const   SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
