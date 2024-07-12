import 'package:flutter/material.dart';
import 'divider_button.dart';
import 'thing_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rank Everything'),
      ),
      body: const Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ThingView(top: true),
              ThingView(top: false),
            ],
          ),
          DividerButton(),
        ],
      ),
    );
  }
}
