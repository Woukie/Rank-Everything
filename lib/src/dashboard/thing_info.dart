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

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          Builder(builder: (context) {
            double percentageAgree = thing!.votes /
                (thingProvider.thing1!.votes + thingProvider.thing2!.votes);

            if (selected) {
              return Column(
                children: [
                  LinearProgressIndicator(
                    minHeight: 24,
                    borderRadius: BorderRadius.circular(12),
                    value: percentageAgree,
                  ),
                  Text(
                      "${(percentageAgree * 100).toInt()}% of people agree with you")
                ],
              );
            }

            return Container();
          }),
        ],
      ),
    );
  }
}
