import 'package:calendar/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, event, child) {
      return event.events.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (String e in event.events)
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                      bottom: 10,
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20,
                            color: Colors.black.withOpacity(.1)),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.grey[400],
                            ),
                            onPressed: () {
                              //
                            }),
                      ],
                    ),
                  )
              ],
            )
          : const Center(child: Text('No Event'));
    });
  }
}
