import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/network_image_widget.dart';
import '../../../core/constant/constant_assets.dart';
import '../../../core/theme/theme_cubit.dart';

class FeelingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final List<Color>? tabGradient;
  final bool? isHomeNava;
  final VoidCallback? onTap;

  const FeelingCard({
    super.key,
    this.tabGradient,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.isHomeNava,
    this.onTap
  });
  Color darken(Color color, [double amount = .2]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        //color: isDark ? const Color(0xFF121212) : Colors.white,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
              colors: tabGradient!
                  .map((color) => color.withOpacity(isDark ? 0.5 : 0.7))
                  .toList(),
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
              top: Radius.circular(20),
            ),
            border: BoxBorder.all(
              color: tabGradient!.last.withOpacity(1),
              width: 2,
            )
        ),
        child: SizedBox(
          width: 160,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: NetworkImageWidget(
                    imageUrl: imageUrl,
                    height: 100,
                    width: double.infinity,
                    borderRadius: 15,
                    fit: BoxFit.cover,
                    fallbackAsset: ConstantAssets.nuLookLogo,
                    grayscaleFallback: true,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  maxLines: 3,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: tabGradient!.last,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_outward_rounded,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}