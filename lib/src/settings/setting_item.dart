import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.body,
    required this.child,
  });

  final String title, body;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  body,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            child,
          ],
        ),
        const Divider(),
      ],
    );
  }
}
