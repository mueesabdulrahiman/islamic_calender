import 'package:flutter/material.dart';

class HadeesSlider extends StatelessWidget {
  HadeesSlider(this._haddeses);

  List _haddeses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (String h in _haddeses)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            //height: 200,
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 5),
            child: GestureDetector(
              onTap: () {
                //
              },
              child: Text(
                "${h}",
                style: TextStyle(
                    //
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          )
      ],
    );
  }

  //   return CarouselSlider(
  //     items: _haddeses
  //         .map(
  //           (e) => Container(
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(15),
  //             ),
  //             height: 100,
  //             padding: EdgeInsets.all(15),
  //             alignment: Alignment.center,
  //             margin: EdgeInsets.only(right: 15, left: 15),
  //             child: GestureDetector(
  //               onTap: () {
  //                 //
  //               },
  //               child: Text(
  //                 "${e}",
  //                 style: TextStyle(
  //                     //
  //                     ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ),
  //         )
  //         .toList(),
  //     options: CarouselOptions(
  //       autoPlay: true,
  //       aspectRatio: 2.0,
  //       viewportFraction: 1.0,
  //       enlargeCenterPage: false,
  //       scrollDirection: Axis.vertical,
  //       // enlargeStrategy: CenterPageEnlargeStrategy.height,
  //     ),
  //   );
  // }
}
