import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nulook_app/core/constant/constant_assets.dart';

import '../../core/theme/theme_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _header(context),
            const SizedBox(height: 16),
            _tabs(),
            const SizedBox(height: 20),

            /// Service Card
            const FavoriteServiceCard(),

            /// Salon Card
            const FavoriteSalonCard(),

            /// Offer / Package Card
            const FavoriteOfferCard(),

            /// Another Service
            const FavoriteServiceCard(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Favorites",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _tabs() {
    return Row(
      children: const [
        _TabChip(title: "All", isSelected: true),
        _TabChip(title: "Salons", isSelected: true),
        _TabChip(title: "Packages", isSelected: true),
        _TabChip(title: "Services", isSelected: true),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  final String title;
  final bool isSelected;

  const _TabChip({
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white12 : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class FavoriteServiceCard extends StatelessWidget {
  const FavoriteServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              ConstantAssets.imagesFour,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: .start,
            children: [
              Text(
                "Essential Glow Facial",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "A balanced facial design...",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 6),
              _actions(),
            ],
          )
        ],
      ),
    );
  }
}

class FavoriteSalonCard extends StatelessWidget {
  const FavoriteSalonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              ConstantAssets.imagesFour,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    "The Galleria",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "4140 Parker Rd, Allentown",
                    style: TextStyle( fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14),
                      SizedBox(width: 4),
                      Text("8 km", style: TextStyle()),
                    ],
                  ),
                  _actions(),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class FavoriteOfferCard extends StatelessWidget {
  const FavoriteOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  ConstantAssets.imagesFour,

                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "30% off",
                    style: TextStyle(),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    "₹1,199",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Corporate Essential Grooming",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _actions() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: .center,
    children: [
      Text(
        "₹1,199/-",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 80),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.favorite, color: Colors.red, size: 18),
      ),
      const SizedBox( width: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "Book",
          style: TextStyle(),
        ),
      ),
    ],
  );
}

