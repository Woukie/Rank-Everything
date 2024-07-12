import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rank_everything/src/dashboard/thing.dart';

class ThingImage extends StatelessWidget {
  const ThingImage({
    super.key,
    required this.thing,
  });

  final Thing thing;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      thing.image,
      fit: BoxFit.cover,
      frameBuilder: (
        BuildContext context,
        Widget child,
        int? frame,
        bool synchronouslyLoaded,
      ) =>
          synchronouslyLoaded
              ? child
              : child.animate().fade().scaleXY(
                    begin: 0.8,
                    curve: Curves.bounceOut,
                  ),
      errorBuilder: (context, error, stackTrace) => const Card(
        margin: EdgeInsets.zero,
        child: Icon(Icons.image_not_supported_outlined),
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ).animate().fadeIn(),
        );
      },
    );
  }
}
