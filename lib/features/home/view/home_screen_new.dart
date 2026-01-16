import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import 'package:nulook_app/features/home/bloc/home_cubit.dart';
import '../../../common/bloc/user_pref_cubit.dart';
import '../../../common/widgets/cardview_text_image.dart';
import '../../../common/widgets/feeling_card_shimmer.dart';
import '../../../common/widgets/glass_icon_button.dart';
import '../../../common/widgets/home_shimmer_screen.dart';
import '../../../common/widgets/network_image_widget.dart';
import '../../../common/widgets/notification_badge_Icon.dart';
import '../../../core/constant/constant_assets.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/theme_cubit.dart';
import '../widgets/feelings_section_today.dart';
import '../widgets/ready_for_section.dart';

enum HomeTab { classic, premium, signature, luxe }

class HomeScreen extends StatefulWidget {
  final Function(bool) onTap;

  const HomeScreen({super.key, required this.onTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final tabs = ['Classic', 'Premium', 'Signature', 'Luxe'];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _simulateLoading();
    callingApi();
    super.initState();
  }

  callingApi() {
   Future.wait([
     context.read<HomeCubit>().loadTodayFeeling(type: "mood"),
     context.read<HomeCubit>().loadOccasionForReady(type: "occasion"), //occasion
   ]);
  }

  HomeTab selectedTab = HomeTab.classic;
  Map<HomeTab, List<Color>> tabGradients = {
    HomeTab.classic: [Color(0xFF2C0202), Color(0xFF630000)],
    HomeTab.premium: [Color(0xFF022732), Color(0xFF005488)],
    HomeTab.signature: [Color(0xFF29033C), Color(0xFF580159)],
    HomeTab.luxe: [Color(0xFF3A3102), Color(0xFFA28700)],
  };

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

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 170),
        child: buildHeaderWidget(),
      ),
      //body: isLoading ? HomeShimmerScreen() : _bodySection(),
      body: _bodySection(),
    );
  }

  Widget _bodySection() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _bannerCard(),
                const SizedBox(height: 10),
                _feelingSection(state),
                const SizedBox(height: 10),
                _occasionReadySection(state),
                const SizedBox(height: 10),
                _buildLookSection(),
                const SizedBox(height: 10),
                _buildEssentialGrooming(state),
                const SizedBox(height: 10),
                _buildCategorySection(),
                const SizedBox(height: 10),
                _buildPopularStylists(),
                const SizedBox(height: 10),
                _buildNearestSalons(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _feelingSection(HomeState state) {
    if (state.isFeelingLoading) return FeelingSectionShimmer();

    if (state.feelingError != null) {
      return Text(state.feelingError!, style: TextStyle(color: Colors.red));
    }

    if (state.feelings.isEmpty) {
      return const Text("No feelings found", style: TextStyle(color: Colors.white54));
    }

    return FeelingsSection(
      tabGradient: tabGradients[selectedTab],
      isHomeNava: true,
      feelings: state.feelings,
    );
  }

  Widget _occasionReadySection(HomeState state) {
    if (state.isOccasionLoading) return FeelingSectionShimmer();

    if (state.occasionError != null) {
      return Text(state.occasionError!, style: TextStyle(color: Colors.red));
    }

    if (state.occasionsReady.isEmpty) {
      return const Text("No occasions found", style: TextStyle(color: Colors.white54));
    }

    return ReadyForSection(
      occasionReady: state.occasionsReady,
    );
  }

  Widget buildHeaderWidget() {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.fromLTRB(0, 170, 10, 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  tabGradients[selectedTab] ?? [Colors.black, Colors.black87],
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: HomeTab.values.map((tab) {
              final isSelected = selectedTab == tab;
              return GestureDetector(
                onTap: () => setState(() => selectedTab = tab),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDark ? Colors.black : Colors.white)
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
                          ? (isDark ? Colors.white : Colors.black)
                          : Colors.white70,
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
        header(),
      ],
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(height: 50),
          BlocBuilder<UserPrefCubit, UserPrefState>(
            builder: (context, state) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      widget.onTap(true);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: NetworkImageWidget(
                        imageUrl: state.userPicture,
                        height: 50,
                        width: 50,
                        borderRadius: 50,
                        fit: BoxFit.fitWidth,
                        fallbackAsset: ConstantAssets.nuLookLogo,
                        grayscaleFallback: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        state.userName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      GlassIconButton(
                        icon: Icons.search,
                        isDecoration: true,
                        showDot: false,
                        themeMode: false,
                        onTap: () {
                          context.pushNamed(AppRouterConstant.salonsPage);
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return SalonsPage.getRouteInstance();
                          //     },
                          //   ),
                          // );
                        },
                      ),
                      const SizedBox(width: 12),
                      // NotificationBadgeIcon(count: 5, onTap: () {
                      //   context.push(AppRouterConstant.notifications);
                      // }),
                      GlassIconButton(
                        icon: Icons.notifications_none,
                        isDecoration: true,
                        showDot: false,
                        themeMode: false,
                        onTap: () {
                          context.push(AppRouterConstant.notifications);
                        },
                      ),
                    ],
                  ),
                  // _icon(Icons.search),
                  // _icon(Icons.notifications_none),
                ],
              );
            },
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Text(
                getGreeting(),
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w100,
                ),
              ),
              Spacer(),
              const FaIcon(
                FontAwesomeIcons.locationDot,
                size: 18,
                color: AppColors.whiteColor,
              ),
              SizedBox(width: 6),
              Text(
                "Hi-tech City, Madhapur",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Icon(icon, color: AppColors.whiteColor, size: 30),
    );
  }

  Widget _tabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(30),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: AppColors.textGrey,
        tabs: tabs
            .map(
              (e) => Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    e,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _tabContent(String type) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _bannerCard(),
          const SizedBox(height: 20),
          _sectionTitle(
            title: "How do you want to feel today?",
            action: "See All",
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _feelCard(
                  title: "Fresh",
                  subtitle: "I want to feel clean,\nlight, and reset.",
                  image:
                      "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _feelCard(
                  title: "Confident",
                  subtitle: "I want to feel sharp\nand ready.",
                  image:
                      "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bannerCard() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFF9E7C19)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/banner.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _feelCard({
    required String title,
    required String subtitle,
    required String image,
  }) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              image,
              height: 90,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle({required String title, required String action}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        Text(action, style: const TextStyle(color: AppColors.accentRed)),
      ],
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
            Text(
              "Your Appointments",
              style: TextStyle(
                fontSize: 18,
                //color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Today, Morning",
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
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
                  Text(
                    "At Page 3 luxury Salon\nHair Salon",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              Text(
                "11:00 AM",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
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
        const Text(
          "What's Your Vibe?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: vibes
              .map(
                (vibe) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.redAccent.withOpacity(0.5),
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Icon(
                        vibe['icon'] as IconData,
                        color: Colors.redAccent,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      vibe['label'].toString(),
                      style: const TextStyle(fontSize: 13),
                    ),
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
        const Text(
          "Your Look for Every Moment",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.white60,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/onboard_images/joker.jpg',
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "40 mins",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
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
                          Text(
                            "Executive Ready",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Polished looks for boardrooms.",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Efficiency Guarantee\nin 40mins",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Essential Grooming
  Widget _buildEssentialGrooming(HomeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Essential Grooming",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.feelings.length > 4 ? 4 : state.feelings.length, // Show 4 items
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1, // adjust height/width ratio
          ),
          itemBuilder: (context, index) {
            return CardViewTextWithImage(
              title: state.feelings[index].name ?? 'Title',
              subtitle: state.feelings[index].description ?? 'Subtitle',
              imageUrl: state.feelings[index].image ?? '',
            );
          },
        ),
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
        const Text(
          "What you want us to do?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
                          color: Colors.redAccent.withOpacity(0.6),
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Icon(
                        item['icon'] as IconData,
                        color: Colors.redAccent,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['label']!.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Popular Stylists
  Widget _buildPopularStylists() {
    final stylists = [
      {
        'image': ConstantAssets.imagesOne,
        'name': 'Lily',
        'role': 'Hair Stylist',
      },
      {'image': ConstantAssets.imagesTwo, 'name': 'Lee', 'role': 'Sx Barber'},
      {
        'image': ConstantAssets.imagesThree,
        'name': 'Connor',
        'role': 'Makeup Artist',
      },
      {
        'image': ConstantAssets.imagesFour,
        'name': 'Jason',
        'role': 'Hair Stylist',
      },
      {
        'image': ConstantAssets.imagesOne,
        'name': 'Jason one',
        'role': 'Hair Stylist',
      },
      {
        'image': ConstantAssets.imagesTwo,
        'name': 'Jason two',
        'role': 'Hair Stylist',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Popular Stylists",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
                  Text(
                    stylist['name']!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    stylist['role']!,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
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
            Text(
              "Nearest Salons",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "View All",
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  'assets/onboard_images/1.jpg',
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mirrors Luxury Salons",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                    const Text(
                      "6391 Elgin St. Celina, Delaware 10299",
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white54,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "5 km",
                          style: TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
