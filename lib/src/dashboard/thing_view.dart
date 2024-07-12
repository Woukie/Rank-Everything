import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: switch (thingProvider.gameState) {
              GameState.idle => Container(),
              GameState.starting =>
                const Center(child: CircularProgressIndicator()),
              GameState.choosing => Transform.scale(
                  scale: 1.1,
                  child: GestureDetector(
                    onTap: () => thingProvider.selectThing(top ? 1 : 2),
                    child: ThingImage(url: thing!.image),
                  ),
                ),
              GameState.chosen => Stack(
                  fit: StackFit.expand,
                  children: [
                    ThingImage(url: thing!.image)
                        .animate()
                        .scaleXY(
                          begin: 1.1,
                          end: selected ? 1.15 : 1.05,
                          curve: Curves.bounceOut,
                        )
                        .blurXY(end: selected ? 0 : 2),
                    !selected
                        ? Container()
                        : Column(
                            mainAxisAlignment: top
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  6,
                                  top ? 6 : 24,
                                  6,
                                  top ? 24 : 6,
                                ),
                                child: LinearProgressIndicator(
                                  minHeight: 24,
                                  borderRadius: BorderRadius.circular(12),
                                  value: thing.votes /
                                      (thingProvider.thing1!.votes +
                                          thingProvider.thing2!.votes),
                                ).animate().scaleX(
                                      delay: const Duration(milliseconds: 250),
                                      alignment: Alignment.bottomLeft,
                                    ),
                              ).animate().scaleY(
                                    alignment: top
                                        ? Alignment.bottomCenter
                                        : Alignment.topCenter,
                                  ),
                            ],
                          )
                  ],
                )
            },
          ),
        ),
      ),
    );
  }
}
