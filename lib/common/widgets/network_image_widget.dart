import 'package:flutter/material.dart';
import '../../core/constant/constant_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String fallbackAsset;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;
  final double fallbackOpacity;
  final bool grayscaleFallback;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.fallbackAsset = ConstantAssets.nuLookLogo,
    this.height = double.infinity,
    this.width = double.infinity,
    this.borderRadius = 8,
    this.fit = BoxFit.cover,
    this.fallbackOpacity = 0.4,
    this.grayscaleFallback = true,
  });

  bool _isValidUrl(String? url) {
    return url != null && url.trim().isNotEmpty && (url.startsWith('http://') || url.startsWith('https://'));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      child: _isValidUrl(imageUrl)
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              height: height,
              width: width,
              fit: fit,
              fadeInDuration: const Duration(milliseconds: 200),
              progressIndicatorBuilder: (context, url, downloadProgress) => _fallbackImage(),
              errorWidget: (_, __, ___) => _fallbackImage(),
            )
          : _fallbackImage(),
    );
  }

  Widget _fallbackImage() {
    final image = Image.asset(
      fallbackAsset,
      height: height,
      width: width,
      fit: fit,
    );

    if (!grayscaleFallback) {
      return Opacity(opacity: fallbackOpacity, child: image);
    }

    return Opacity(
      opacity: fallbackOpacity,
      child: ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        child: image,
      ),
    );
  }
}

// class NetworkImageWidget extends StatelessWidget {
//   final String? imageUrl;
//   final String fallbackAsset;
//   final double height;
//   final double width;
//   final double borderRadius;
//   final BoxFit fit;
//   final double fallbackOpacity;
//   final bool grayscaleFallback;
//
//   const NetworkImageWidget({
//     super.key,
//     required this.imageUrl,
//     this.fallbackAsset = ConstantAssets.nuLookLogo,
//     this.height = double.infinity,
//     this.width = double.infinity,
//     this.borderRadius = 8,
//     this.fit = BoxFit.cover,
//     this.fallbackOpacity = 0.4,
//     this.grayscaleFallback = true,
//   });
//
//   bool _isValidUrl(String? url) {
//     return url != null &&
//         url.trim().isNotEmpty &&
//         (url.startsWith('http://') || url.startsWith('https://'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(borderRadius),
//       clipBehavior: Clip.antiAlias,
//       child: _isValidUrl(imageUrl)
//           ? Image.network(
//               imageUrl!,
//               height: height,
//               width: width,
//               fit: fit,
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) return child;
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: Colors.redAccent,
//                   ),
//                 );
//               },
//               errorBuilder: (_, __, ___) => _fallbackImage(),
//             )
//           : _fallbackImage(),
//     );
//   }
//
//   Widget _fallbackImage() {
//     final image = Image.asset(
//       fallbackAsset,
//       height: height,
//       width: width,
//       fit: fit,
//     );
//
//     if (!grayscaleFallback) {
//       return Opacity(opacity: fallbackOpacity, child: image);
//     }
//
//     return Opacity(
//       opacity: fallbackOpacity,
//       child: ColorFiltered(
//         colorFilter: const ColorFilter.matrix([
//           0.2126,
//           0.7152,
//           0.0722,
//           0,
//           0,
//           0.2126,
//           0.7152,
//           0.0722,
//           0,
//           0,
//           0.2126,
//           0.7152,
//           0.0722,
//           0,
//           0,
//           0,
//           0,
//           0,
//           1,
//           0,
//         ]),
//         child: image,
//       ),
//     );
//   }
// }
