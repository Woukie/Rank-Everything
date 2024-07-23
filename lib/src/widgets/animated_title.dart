import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedTitle extends StatefulWidget {
  const AnimatedTitle({
    super.key,
    required this.controller,
  });

  final TabController controller;

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller.animation!,
      builder: (context, child) {
        // animProgress starts at 0 and ends at either -1 or 1 depending on swipe direction
        double animProgress = widget.controller.offset;

        int target = widget.controller.index;
        int previous = widget.controller.previousIndex;

        bool fast = widget.controller.indexIsChanging;

        if (fast) {
          animProgress /= (target - previous).abs();

          bool forwards = target - previous > 0;
          animProgress += forwards ? 1 : -1;
        }

        return Transform.translate(
          offset: Offset(sin(animProgress * pi) * 100, 0),
          child: Row(
            children: [
              Expanded(
                child: Opacity(
                  opacity: 1 - sin(animProgress * pi).abs(),
                  child: Text(
                    ["Stats", "Rank Everything", "Settings"][fast
                        ? animProgress.abs() > 0.5
                            ? target
                            : previous
                        : widget.controller.animation!.value.round()],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
