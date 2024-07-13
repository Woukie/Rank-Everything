import 'package:flutter/material.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

class ThingInfo extends StatelessWidget {
  const ThingInfo({
    super.key,
    required this.thing,
    required this.thingProvider,
    required this.selected,
  });

  final Thing? thing;
  final ThingProvider thingProvider;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    if (thing == null) return Container();

    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              thing!.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              thing!.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
