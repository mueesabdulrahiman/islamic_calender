import 'package:calendar/providers/data.dart';
import 'package:calendar/widgets/hadees_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HadeesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('helloooo2');
    return Consumer<Data>(
      builder: (context, data, child) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            if (data.hadeesTopAd != null)
              const Column(
                children: [
                  // AdWidget(
                  //   // data.hadeesTopAd["link"],
                  //   data.hadeesTopAd?["image"],
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            HadeesSlider(data.allHadees),
            if (data.hadeesTopAd != null)
              const Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  // AdWidget(
                  //   // data.hadeesBottomAd["link"],
                  //   data.hadeesBottomAd?["image"],
                  // ),
                ],
              ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
