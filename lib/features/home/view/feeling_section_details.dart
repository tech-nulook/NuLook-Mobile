import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Features/Home/widgets/feelings_section_today.dart';
import '../../../core/theme/theme_cubit.dart';
import '../widgets/grooming_pack_card.dart';

enum Tab { AllOffers, packages, services }

class FeelingSectionDetails extends StatefulWidget {
  final List<Color>? tabGradient;
  const FeelingSectionDetails({super.key, this.tabGradient,});

  @override
  State<FeelingSectionDetails> createState() => _FeelingSectionDetailsState();
}

class _FeelingSectionDetailsState extends State<FeelingSectionDetails> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  final List<String> vendorCategory = [
    "All",
    "Students",
    "Professionals",
    "Families",
    "Couples",
    "Influencers",
  ];
  Map<Tab, List<Color>> tabGradients = {
    Tab.AllOffers: [Color(0xFF000000), Color(0xFF630000)],
    Tab.packages: [Color(0xFF000000), Color(0xFF005488)],
    Tab.services: [Color(0xFF000000), Color(0xFF580159)],
  };

  Tab selectedTab = Tab.AllOffers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feeling Section Details')),
      body: _bodySection(),
    );
  }

  Widget _bodySection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            _categoryListWidget(),
            const SizedBox(height: 10),
           // FeelingsSection(tabGradient: widget.tabGradient , isHomeNava: false),
            buildAnimatedContainer(),
          ],
        ),
      ),
    );
  }

  Padding _categoryListWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: vendorCategory.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  if (selectedIndex == 0) {
                  } else {}
                  debugPrint("selectedIndex:--- $selectedIndex");
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.transparent : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: isSelected ? Colors.redAccent : Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Text(
                    vendorCategory[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.redAccent : null,
                      fontFamily: 'Montserrat',
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildAnimatedContainer() {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.topCenter,
            //   colors: tabGradients[selectedTab] ?? [Colors.black, Colors.black87],
            // ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(0),
            ),
          ),
          child: Row(
            mainAxisAlignment: .spaceEvenly,
            children: Tab.values.map((tab) {
              final isSelected = selectedTab == tab;
              return GestureDetector(
                onTap: () => setState((){
                  selectedTab = tab;
                  debugPrint('Selected Tab: ${selectedTab.index}');
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? const Color(0xFF1C1C1E) : const Color(0x241C1C1E))
                        : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      color: isSelected
                          ? (isDark ? Colors.white : Colors.black) // (isDark ? Colors.white : Colors.black)
                          : (isDark ? Colors.white : Colors.black) ,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    child: Text(
                      tab.name[0].toUpperCase() + tab.name.substring(1),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        Container(
          height: 550,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C1C1E) : const Color(0x241C1C1E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: groomingPackListWidget(),
        ),
      ],
    );
  }

  Widget groomingPackListWidget() {
    return SizedBox(
      height: 530,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vendorCategory.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
            },
            child: GroomingPackCard(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              imageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
              title: 'Corporate Essential Grooming',
              subtitle: 'Everyday Corporate Ready',
              description: 'A quick, professional grooming session to keep you polished and office-ready.',
              price: '1,499',
              discountText: '30% Off',
              rating: 4.0,
              reviews: 76,
              duration: '25–35 mins',
              onTap: () {
                debugPrint('CTA clicked');
              },
              onWishlist: () {
                debugPrint('Wishlist');
              },
              onShare: () {
                debugPrint('Share');
              },
            ),
          );
        },
      ),
    );
  }
}
