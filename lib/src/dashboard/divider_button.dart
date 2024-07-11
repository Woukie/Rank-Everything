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

    return Row(
      children: [
        const Expanded(child: Divider()),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return SizeTransition(sizeFactor: animation, child: child);
          },
          child: switch (thingProvider.gameState) {
            GameState.idle => FilledButton(
                key: const Key("Idle"),
                onPressed: () {
                  thingProvider.loadNextThings();
                },
                child: const Text("Begin!"),
              ),
            GameState.starting => Container(),
            GameState.choosing => FilledButton(
                key: const Key("Choosing"),
                onPressed: () {},
                child: const Text("VS"),
              ),
            GameState.chosen => FilledButton(
                key: const Key("Next"),
                onPressed: () {
                  thingProvider.loadNextThings();
                },
                child: const Text("Next"),
              ),
          },
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
