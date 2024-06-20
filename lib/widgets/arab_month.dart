import 'package:calendar/providers/arab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArabMonth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Arab>(
      builder: (context, arab, child) => Text(
        (arab.month != null 
      //  && arab.month.isNotEmpty
        ) ? "${arab.month}" : "Nil",
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
