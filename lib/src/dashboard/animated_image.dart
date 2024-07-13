import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedImage extends StatelessWidget {
  const AnimatedImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Image.network(
            url,
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
          ),
        ),
      ],
    );
  }
}
