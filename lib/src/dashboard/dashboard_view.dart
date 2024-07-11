import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';

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
      body: Column(
        children: [
          ThingView(thing: thingProvider.thing1),
          const Divider(),
          ThingView(thing: thingProvider.thing2),
        ],
      ),
    );
  }
}

class ThingView extends StatelessWidget {
  const ThingView({super.key, required this.thing});

  final Thing? thing;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: thing != null
          ? Image.network(thing!.image)
          : const CircularProgressIndicator(),
    );
  }
}
