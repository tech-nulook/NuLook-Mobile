import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class FeelingSectionShimmer extends StatelessWidget {

  const FeelingSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _rect(height: 14),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: _card(height: 70),
              );
            },
          ),
        ),

      ],
    );
  }

  Widget _circle(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade300,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _rect({double width = double.infinity, double height = 16}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade400,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _card({required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade600,
      highlightColor: Colors.grey.shade500,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class FeelingCardShimmer extends StatelessWidget {
  final List<Color> tabGradient;
  final bool isDark;

  const FeelingCardShimmer({
    super.key,
    required this.tabGradient,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp, colors: [],
         // colors: bgColors,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
          top: Radius.circular(20),
        ),
        border: Border.all(
          color: tabGradient.last.withOpacity(1),
          width: 2,
        ),
      ),
      child: SizedBox(
        width: 160,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(isDark ? 0.10 : 0.20),
            highlightColor: Colors.white.withOpacity(isDark ? 0.25 : 0.35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image shimmer
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                // Title shimmer
                Container(
                  height: 12,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                const SizedBox(height: 6),

                // Subtitle shimmer lines
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 10,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 10,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                const Spacer(),

                // Bottom right icon shimmer
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
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