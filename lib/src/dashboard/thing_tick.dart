import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

class ThingTick extends StatelessWidget {
  const ThingTick({
    super.key,
    this.thing,
    required this.selected,
    required this.top,
  });

  final Thing? thing;
  final bool selected, top;

  @override
  Widget build(BuildContext context) {
    ThingProvider thingProvider = Provider.of<ThingProvider>(context);

    return Align(
      alignment: top ? Alignment.topLeft : Alignment.bottomLeft,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: (!selected ||
                thing == null ||
                thingProvider.gameState != GameState.chosen)
            ? const SizedBox(
                width: 1,
                height: 1,
              )
            : FloatingActionButton.small(
                onPressed: null,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                child: const Icon(Icons.check),
              ),
      ),
    );
  }
}
