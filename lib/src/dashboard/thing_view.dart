import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: switch (gameState) {
              GameState.idle => Container(),
              GameState.starting =>
                const Center(child: CircularProgressIndicator()),
              GameState.choosing => Transform.scale(
                  scale: 1.1,
                  child: GestureDetector(
                    onTap: onSelect,
                    child: ThingImage(thing: thing!),
                  ),
                ),
              GameState.chosen => Stack(
                  fit: StackFit.expand,
                  children: [
                    ThingImage(thing: thing!)
                        .animate()
                        .scaleXY(
                          begin: 1.1,
                          end: selected ? 1.15 : 1.05,
                          curve: Curves.bounceOut,
                        )
                        .blurXY(end: selected ? 0 : 2),
                  ],
                )
            },
          ),
        ),
      ),
    );
  }
}
