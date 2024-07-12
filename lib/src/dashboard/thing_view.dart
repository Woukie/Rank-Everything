import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

import 'thing_image.dart';

class ThingView extends StatelessWidget {
  const ThingView({
    super.key,
    required this.thing,
    required this.selected,
    required this.onSelect,
  });

  final Thing? thing;
  final bool selected;
  final Function() onSelect;

  @override
  Widget build(BuildContext context) {
    ThingProvider thingProvider = Provider.of<ThingProvider>(context);

    GameState gameState = thingProvider.gameState;

    return Expanded(
      child: switch (gameState) {
        GameState.idle => Container(),
        GameState.starting => const Center(child: CircularProgressIndicator()),
        _ => GestureDetector(
            onTap: onSelect,
            child: ThingImage(thing: thing!),
          ),
      },
    );
  }
}
