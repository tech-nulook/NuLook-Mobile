import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'home_shimmer_screen.dart';

class ShimmerSkeleton extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const ShimmerSkeleton.rect({
    Key? key,
    this.height = 16,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : super(key: key);

  // small reusable skeleton for avatar+text
  factory ShimmerSkeleton.row({Key? key}) {
    return ShimmerSkeleton._row(key: key);
  }

  const ShimmerSkeleton._row({Key? key})
      : height = 60,
        width = double.infinity,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 1200),
      child: HomeShimmerScreen()
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    // If this is the row factory, return avatar + two lines
    if (height == 60 && width == double.infinity && borderRadius.topLeft.x == 8) {
      return Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 12, width: double.infinity, color: Colors.black),
                const SizedBox(height: 8),
                Container(height: 12, width: 150, color: Colors.black),
              ],
            ),
          ),
        ],
      );
    }

    // Generic rectangle skeleton
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: borderRadius,
      ),
    );
  }
}