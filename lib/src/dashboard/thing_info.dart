import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rank_everything/src/dashboard/thing.dart';

class ThingInfo extends StatelessWidget {
  const ThingInfo({
    super.key,
    required this.thing,
    required this.selected,
    required this.top,
  });

  final Thing? thing;
  final bool selected, top;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          axis: Axis.vertical,
          sizeFactor: animation,
          axisAlignment: top ? -1 : 0,
          child: child,
        );
      },
      child: thing == null
          ? const SizedBox(height: 1, width: 1)
          : Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainer
                            .withAlpha(150),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            6,
                            !top ? 24 : 6,
                            6,
                            top ? 24 : 6,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                thing!.name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                thing!.description,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
