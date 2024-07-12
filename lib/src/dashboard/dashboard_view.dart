import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

import 'divider_button.dart';
import 'thing_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThingProvider thingProvider = Provider.of<ThingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rank Everything'),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ThingView(
                thing: thingProvider.thing1,
                selected: thingProvider.selectedThing == 1,
                onSelect: () => thingProvider.selectThing(1),
              ),
              ThingView(
                thing: thingProvider.thing2,
                selected: thingProvider.selectedThing == 2,
                onSelect: () => thingProvider.selectThing(2),
              ),
            ],
          ),
          const DividerButton(),
        ],
      ),
    );
  }
}
