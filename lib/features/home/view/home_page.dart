import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nulook_app/common/utils.dart';
import 'package:nulook_app/common/widgets/home_shimmer_screen.dart';
import 'package:nulook_app/core/constant/constant_assets.dart';

import '../../../common/rounded_textfield.dart';
import '../../OnBoarding/view/onboarding_page.dart';
import '../widgets/location_bottom_sheet_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    _simulateLoading();
    super.initState();
  }

  //Create a loading state variable
  bool isLoading = false;

  Future<void> _simulateLoading() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //backgroundColor: Colors.black,
      body: isLoading ? HomeShimmerScreen() : _bodySection(),
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
            _buildLocation(),
            _buildAppointments(),
            _buildVibeSection(),
            _buildLookSection(),
            _buildEssentialGrooming(),
            _buildCategorySection(),
            _buildPopularStylists(),
            _buildNearestSalons(),
          ],
        ),
      ),
    );
  }

  // Location section
  Widget _buildLocation() {
    return InkWell(
      onTap: () {
        // Handle location tap
        Utils.openModalBottomSheet(context,
            LocationBottomSheetWidget(),
            isScrollControlled: true,
            staticContent: true);
      },
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.white70,
        margin: const EdgeInsets.symmetric(vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children:  [
            const FaIcon(FontAwesomeIcons.locationDot, size: 18),
            SizedBox(width: 6),
            Text("Hi-tech City, Madhapur", style: TextStyle(fontSize: 14)),
          ],
        ),
       ),
      ),
    );
  }

  // Appointment card
  Widget _buildAppointments() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: const [
            Text("Your Appointments",
                style: TextStyle(
                    fontSize: 18,
                    //color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Text("Today, Morning",
                style: TextStyle(color: Colors.white54, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF5A1E25),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 10),
                  Text("At Page 3 luxury Salon\nHair Salon",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
              Text("11:00 AM",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        )
      ],
    );
  }

  // Vibe section
  Widget _buildVibeSection() {
    final vibes = [
      {'icon': Icons.wb_sunny_outlined, 'label': 'Glow'},
      {'icon': Icons.spa_outlined, 'label': 'Unwind'},
      {'icon': Icons.celebration_outlined, 'label': 'Chill'},
      {'icon': Icons.party_mode_outlined, 'label': 'Celebrate'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("What's Your Vibe?",
            style: TextStyle(
                fontSize: 18,  fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: vibes.map((vibe) => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                    border:
                    Border.all(color: Colors.redAccent.withOpacity(0.5)),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Icon(vibe['icon'] as IconData,
                      color: Colors.redAccent, size: 28),
                ),
                const SizedBox(height: 6),
                Text(vibe['label'].toString(),
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  // Look section
  Widget _buildLookSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Your Look for Every Moment",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.white60,
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  children: [
                    Image.asset('assets/onboard_images/joker.jpg',height: 100,width: double.infinity, fit: BoxFit.cover),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "40 mins",
                          style: TextStyle( fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Executive Ready",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text("Polished looks for boardrooms.",
                              style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text("Efficiency Guarantee\nin 40mins",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // Essential Grooming
  Widget _buildEssentialGrooming() {
    final images = [ConstantAssets.imagesOne,ConstantAssets.imagesTwo,ConstantAssets.imagesThree];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Essential Grooming", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: images.map((img) => Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(img, fit: BoxFit.cover),
            ),
          ),
          )
              .toList(),
        )
      ],
    );
  }

  // Category chips
  Widget _buildCategorySection() {
    final categories = [
      {'icon': Icons.content_cut, 'label': 'Haircut'},
      {'icon': Icons.brush_outlined, 'label': 'Nails'},
      {'icon': Icons.face_retouching_natural, 'label': 'Facial'},
      {'icon': Icons.color_lens_outlined, 'label': 'Coloring'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("What you want us to do?",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories
              .map(
                (item) => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.redAccent.withOpacity(0.6)),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Icon(item['icon'] as IconData,
                      color: Colors.redAccent, size: 28),
                ),
                const SizedBox(height: 6),
                Text(item['label']!.toString(),
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 13)),
              ],
            ),
          )
              .toList(),
        )
      ],
    );
  }

  // Popular Stylists
  Widget _buildPopularStylists() {
    final stylists = [
      {'image': ConstantAssets.imagesOne, 'name': 'Lily', 'role': 'Hair Stylist'},
      {'image': ConstantAssets.imagesTwo, 'name': 'Lee', 'role': 'Sx Barber'},
      {'image': ConstantAssets.imagesThree, 'name': 'Connor', 'role': 'Makeup Artist'},
      {'image': ConstantAssets.imagesFour, 'name': 'Jason', 'role': 'Hair Stylist'},
      {'image': ConstantAssets.imagesOne, 'name': 'Jason one', 'role': 'Hair Stylist'},
      {'image': ConstantAssets.imagesTwo, 'name': 'Jason two', 'role': 'Hair Stylist'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Popular Stylists",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: stylists.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final stylist = stylists[index];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(stylist['image']!),
                  ),
                  const SizedBox(height: 8),
                  Text(stylist['name']!,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(stylist['role']!,
                      style:
                      const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // Nearest Salons
  Widget _buildNearestSalons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Nearest Salons",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("View All",
                style: TextStyle(color: Colors.white54, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset('assets/onboard_images/1.jpg',
                    fit: BoxFit.cover, height: 150, width: double.infinity),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mirrors Luxury Salons",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text("6391 Elgin St. Celina, Delaware 10299",
                        style: TextStyle(color: Colors.white54, fontSize: 13)),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined,
                            color: Colors.white54, size: 16),
                        SizedBox(width: 4),
                        Text("5 km",
                            style:
                            TextStyle(color: Colors.white54, fontSize: 13)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}