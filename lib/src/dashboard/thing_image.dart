import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/animated_image.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

class ThingImage extends StatelessWidget {
  const ThingImage({
    super.key,
    required this.top,
    required this.thing,
    required this.selected,
  });

  final bool top;
  final Thing? thing;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    ThingProvider thingProvider = Provider.of<ThingProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: switch (thingProvider.gameState) {
          GameState.idle => Container(),
          GameState.starting =>
            const Center(child: CircularProgressIndicator()),
          _ => Transform.scale(
              scale: 1.1,
              child: AnimatedImage(url: thing!.image),
            ),
        },
      ),
    );
  }
}
