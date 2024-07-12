import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

class DividerButton extends StatelessWidget {
  const DividerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThingProvider thingProvider = Provider.of<ThingProvider>(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: switch (thingProvider.gameState) {
        GameState.idle => FloatingActionButton.extended(
            key: const Key("Idle"),
            onPressed: () {
              thingProvider.loadNextThings();
            },
            label: Text(
              "BEGIN",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        GameState.starting => Container(),
        GameState.choosing => FloatingActionButton.extended(
            key: const Key("Choosing"),
            onPressed: null,
            label: Text(
              "VERSUS",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        GameState.chosen => FloatingActionButton.extended(
            key: const Key("Next"),
            onPressed: () {
              thingProvider.loadNextThings();
            },
            label: Text(
              "NEXT",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
      },
    );
  }
}
