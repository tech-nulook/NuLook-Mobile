import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/network_image_widget.dart';
import '../../../core/constant/constant_assets.dart';
import '../../../core/theme/theme_cubit.dart';

class GroomingPackCard extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description;
  final String price;
  final String discountText;
  final double rating;
  final int reviews;
  final String duration;
  final VoidCallback onTap;
  final VoidCallback onWishlist;
  final VoidCallback onShare;

  const GroomingPackCard({
    super.key,
    required this.height,
    required this.width,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.discountText,
    required this.rating,
    required this.reviews,
    required this.duration,
    required this.onTap,
    required this.onWishlist,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF000000) : Colors.white, // Light card
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? [
                // Soft glow for dark mode
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                // Material-like elevation for light mode
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE SECTION
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: NetworkImageWidget(
                  imageUrl: imageUrl,
                  height: 200,
                  width: double.infinity,
                  borderRadius: 20,
                  fit: BoxFit.cover,
                  fallbackAsset: ConstantAssets.nuLookLogo,
                  grayscaleFallback: true,
                ),
              ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.80),
                      ],
                    ),
                  ),
                ),
              ),

              // Recommended badge
              Positioned(
                top: 30,
                left: 0,
                child: Transform.rotate(
                  angle: -0.6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Recommended',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Discount
              Positioned(
                bottom: 50,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    discountText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Details
              Positioned(
                bottom: 10,
                left: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Everyday Corporate Ready Look",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        "Clean Shave + Haircut + Facial + Spa",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Price
              Positioned(
                bottom: 50,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Starting from\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white,
                          ), // Specific style
                        ),
                        TextSpan(
                          text: '₹$price',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
                          ), // Specific style
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 5),

                // Rating & duration
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '($reviews Reviews)',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: const TextStyle(),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onWishlist,
                      child: const Row(
                        children: [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 6),
                          Text(
                            'Add to Wishlist',
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: onShare,
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // CTA BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: onTap,
                    child: const Text(
                      'Get My Corporate Look Now!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
