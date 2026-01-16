import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerScreen extends StatelessWidget {
  const HomeShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP PROFILE + ICONS
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _circle(50),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _rect(width: 120, height: 14),
                        const SizedBox(height: 6),
                        _rect(width: 90, height: 12),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),
                  _circle(26),
                  const SizedBox(width: 10),
                  _circle(26),
                  const SizedBox(width: 10),
                  _circle(26),
                ],
              ),

              const SizedBox(height: 20),

              /// LOCATION
              _rect(width: 160, height: 14),

              const SizedBox(height: 30),

              /// SECTION TITLE: "Your Appointments"
              _rect(width: 180, height: 16),
              const SizedBox(height: 10),
              _rect(width: 120, height: 13),

              const SizedBox(height: 15),

              /// APPOINTMENT CARD
              _card(height: 70),

              const SizedBox(height: 30),

              /// "What’s Your Vibe?"
              _rect(width: 160, height: 16),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                      (_) => Column(
                    children: [
                      _circle(60),
                      const SizedBox(height: 8),
                      _rect(width: 40, height: 12),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// "Your Look for Every Moment"
              _rect(width: 240, height: 16),
              const SizedBox(height: 16),

              /// BIG CARD (image + text)
              _card(height: 180),

              const SizedBox(height: 30),

              /// Essential Grooming
              _rect(width: 200, height: 16),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _card(height: 100)),
                  const SizedBox(width: 12),
                  Expanded(child: _card(height: 100)),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
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

  Widget _card({required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade400,
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

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0E0E0E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _circle(28),
          _circle(28),
          _circle(28),
          _circle(28),
          _circle(28),
        ],
      ),
    );
  }
}