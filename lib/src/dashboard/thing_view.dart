import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/dashboard/thing_info.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

import 'thing_image.dart';

class ThingView extends StatelessWidget {
  const ThingView({
    super.key,
    required this.top,
  });

  final bool top;

  @override
  Widget build(BuildContext context) {
    ThingProvider thingProvider = Provider.of<ThingProvider>(context);

    Thing? thing = top ? thingProvider.thing1 : thingProvider.thing2;
    bool selected = thingProvider.selectedThing == (top ? 1 : 2);

    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            verticalDirection:
                top ? VerticalDirection.down : VerticalDirection.up,
            children: [
              Expanded(
                child: ThingImage(
                  thingProvider: thingProvider,
                  top: top,
                  thing: thing,
                  selected: selected,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 6)),
              ThingInfo(
                thing: thing,
                thingProvider: thingProvider,
                selected: selected,
              ),
              const Padding(padding: EdgeInsets.only(top: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
