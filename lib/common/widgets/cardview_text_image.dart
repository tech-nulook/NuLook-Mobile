import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/network_image_widget.dart';
import '../../../core/constant/constant_assets.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../Core/Theme/colors.dart';

class CardViewTextWithImage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final bool? isHomeNava;
  final VoidCallback? onTap;

  const CardViewTextWithImage({
    super.key,
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
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 6, // ✅ elevation
        shadowColor: Colors.black.withOpacity(0.25), // ✅ shadow color
        color: isDark ? AppColors.darkColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark
                ? darken(Colors.grey.shade800, 0.3)
                : Colors.grey.shade300,
            width: 0,
          ),
        ),
      // child: Container(
      //   margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      //   decoration: BoxDecoration(
      //    // color: isDark ? const Color(0xFF121212) : Colors.white,
      //     borderRadius: BorderRadius.circular(20),
      //     // ✅ Border
      //     border: Border.all(
      //      // color: isDark ? darken(Colors.grey.shade800, 0.3) : Colors.grey.shade300,
      //       width: 0,
      //     ),
      //     // ✅ Shadow (elevation effect)
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(isDark ? 0.35 : 0.12),
      //         blurRadius: 10,
      //         spreadRadius: 1,
      //         offset: const Offset(0, 6), // shadow direction
      //       ),
      //     ],
      //   ),
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
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
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