import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/dashboard/thing_info.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

import 'thing_image.dart';
import 'thing_results.dart';

class ThingView extends StatefulWidget {
  const ThingView({
    super.key,
    required this.top,
  });

  final bool top;

  @override
  State<ThingView> createState() => _ThingViewState();
}

class _ThingViewState extends State<ThingView> {
  @override
  Widget build(BuildContext context) {
    ThingProvider thingProvider = Provider.of<ThingProvider>(context);

    Thing? thing = widget.top ? thingProvider.thing1 : thingProvider.thing2;
    bool selected = thingProvider.selectedThing == (widget.top ? 1 : 2);

    return GestureDetector(
      onTap: () {
        switch (thingProvider.gameState) {
          case GameState.choosing:
            thingProvider.selectThing(widget.top ? 1 : 2);
            break;
          case GameState.chosen || GameState.idle:
            thingProvider.loadNextThings();
            break;
          default:
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Stack(
            alignment:
                widget.top ? Alignment.bottomCenter : Alignment.topCenter,
            children: [
              ThingImage(
                top: widget.top,
                thing: thing,
                selected: selected,
              ),
              ThingResults(
                widget: widget,
                thingProvider: thingProvider,
                thing: thing,
                selected: selected,
                top: widget.top,
              ),
              ThingInfo(
                thing: thing,
                padding: thingProvider.gameState != GameState.chosen,
                top: widget.top,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
