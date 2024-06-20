import 'package:calendar/widgets/arab_month.dart';
import 'package:calendar/widgets/main_calender.dart';
import 'package:flutter/material.dart';

class CalenderSection extends StatelessWidget {
  const CalenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          // ArabMonth(),
          const SizedBox(
            height: 0,
          ),
          MainCalender(),
        ],
      ),
    );
  }
}
