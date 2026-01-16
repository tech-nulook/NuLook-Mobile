import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nulook_app/features/home/model/feeltoday.dart';

import '../../../common/widgets/network_image_widget.dart';
import '../../../core/constant/constant_assets.dart';
import '../../../core/theme/theme_cubit.dart';



class ReadyForSection extends StatelessWidget {

  final List<FeelToday>?  occasionReady;
  const ReadyForSection({super.key, this.occasionReady});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const SizedBox(height: 16),
        SizedBox(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: occasionReady!.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = occasionReady![index];

                return Padding(
                  padding: EdgeInsets.only(
                    right: index == occasionReady!.length - 1 ? 0 : 16,
                  ),
                  child: ReadyForCard(
                    imageUrl: item.image ?? '',
                    title: item.name!,
                    subtitle: item.description!,
                    discount: '40% Off',
                  ),
                );
              },
            ),
          ),
        ),
        // SizedBox(
        //   height: 300,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: const [
        //       ReadyForCard(
        //         imageUrl:
        //         'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
        //         title: 'Everyday Mode',
        //         subtitle:
        //         'Your everyday look, done effortlessly.\nMost people groom for daily confidence.',
        //         discount: '40% Off',
        //       ),
        //       SizedBox(width: 16),
        //       ReadyForCard(
        //         imageUrl:
        //         'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        //         title: 'Going Out',
        //         subtitle:
        //         'Step out sharp and confident.\nSocial ready styles.',
        //         discount: '30% Off',
        //       ),
        //       SizedBox(width: 16),
        //       ReadyForCard(
        //         imageUrl:
        //         'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
        //         title: 'Everyday Mode',
        //         subtitle:
        //         'Your everyday look, done effortlessly.\nMost people groom for daily confidence.',
        //         discount: '40% Off',
        //       ),
        //       SizedBox(width: 16),
        //       ReadyForCard(
        //         imageUrl:
        //         'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
        //         title: 'Going Out',
        //         subtitle:
        //         'Step out sharp and confident.\nSocial ready styles.',
        //         discount: '30% Off',
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'What are you getting ready for?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'See All',
          style: TextStyle(
            color: Color(0xFFFF4D4D),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ReadyForCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String discount;

  const ReadyForCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.discount,
  });

  Color darken(Color color, [double amount = .2]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;

    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        // ✅ Border
        border: Border.all(
          color: isDark ? darken(Colors.grey.shade800, 0.3) : Colors.grey.shade300,
          width: 0,
        ),
        // ✅ Shadow (elevation effect)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.35 : 0.12),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 6), // shadow direction
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: NetworkImageWidget(
                  imageUrl: imageUrl,
                  height: 200,
                  width: double.infinity,
                  borderRadius: 15,
                  fit: BoxFit.cover,
                  fallbackAsset: ConstantAssets.nuLookLogo,
                  grayscaleFallback: true,
                ),
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
                      Colors.black.withOpacity(0.90),
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Discount Badge
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF000000).withOpacity(0.4),
                      border: Border.all(color: Color(0xFFFF4D4D)),
                    ),
                    child: Text(
                      discount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    subtitle,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Explore
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Explore',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.arrow_outward_rounded,
                        color: Color(0xFFFF4D4D),
                        size: 18,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}