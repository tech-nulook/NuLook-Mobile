import 'package:flutter/material.dart';


class GrayscaleImage extends StatelessWidget {
  final String asset;
  final double opacity;
  final BoxFit fit;
  final BlendMode colorBlendMode;

  const GrayscaleImage({
    super.key,
    required this.asset,
    this.opacity = 1.0,
    this.fit = BoxFit.cover,
    this.colorBlendMode = BlendMode.srcIn,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0,      0,      0,      1, 0,
      ]),
      child: Opacity(
        opacity: opacity,
        child: Image.asset(asset,fit: fit, colorBlendMode: colorBlendMode),
      ),
    );
  }
}
