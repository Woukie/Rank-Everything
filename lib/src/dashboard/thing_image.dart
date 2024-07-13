import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rank_everything/src/dashboard/animated_image.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

class ThingImage extends StatelessWidget {
  const ThingImage({
    super.key,
    required this.thingProvider,
    required this.top,
    required this.thing,
    required this.selected,
  });

  final ThingProvider thingProvider;
  final bool top;
  final Thing? thing;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: switch (thingProvider.gameState) {
          GameState.idle => Container(),
          GameState.starting =>
            const Center(child: CircularProgressIndicator()),
          GameState.choosing => Transform.scale(
              scale: 1.1,
              child: GestureDetector(
                onTap: () => thingProvider.selectThing(top ? 1 : 2),
                child: AnimatedImage(url: thing!.image),
              ),
            ),
          GameState.chosen => Transform.scale(
              scale: 1.1,
              child: AnimatedImage(url: thing!.image).animate().scaleXY(
                    begin: 1,
                    end: selected ? 0.95 : 1.05,
                    curve: Curves.bounceOut,
                  ),
            )
        },
      ),
    );
  }
}
