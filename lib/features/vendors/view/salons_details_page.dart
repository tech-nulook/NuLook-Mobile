import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common_button.dart';
import '../../../common/utils.dart';
import '../../../common/widgets/network_image_widget.dart';
import '../../../common/widgets/no_data_widget.dart';
import '../../../core/constant/constant_assets.dart';
import '../../../features/vendors/model/vendor.dart';
import '../bloc/vendors_cubit.dart';
import '../model/vendor_packages.dart';
import '../widgets/bridal_package_dialog.dart';

class SalonsDetailsPage extends StatefulWidget {
  final Vendors? vendor;

  const SalonsDetailsPage({super.key, required this.vendor});

  @override
  State<SalonsDetailsPage> createState() => _SalonsDetailsPageState();
}

class _SalonsDetailsPageState extends State<SalonsDetailsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int selectedIndex = 0;
  Timer? _timer;
  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7VQJh7ka40x-igYnOoW8UZBFsQylSM_ttzA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1T6PiFxZ2a8mhX145GtxmWr7T_o8LsTsC9w&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ7JeuBhJODHcuTH7QtkNq3S5PEdgCUJ07EQ&s',
  ];

  final List<String> itemsSalon = [
    "Lily",
    "Lee",
    "Connor",
    "Jason",
    "Hari",
    "Shares",
  ];

  final List<String> vendorCategory = [
    "Package",
    "Services",
    "Gallery",
    "Revie",
    "Shares",
    "About",
  ];

  final List<Map<String, dynamic>> itemsSearch = [
    {
      "title": "Café Mocha",
      "subtitle": "Freshly brewed with chocolate",
      "rating": 4.5,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7VQJh7ka40x-igYnOoW8UZBFsQylSM_ttzA&s",
    },
    {
      "title": "Espresso Shot",
      "subtitle": "Strong and aromatic flavor",
      "rating": 4.2,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1T6PiFxZ2a8mhX145GtxmWr7T_o8LsTsC9w&s",
    },
    {
      "title": "Iced Latte",
      "subtitle": "Cold and refreshing",
      "rating": 4.8,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ7JeuBhJODHcuTH7QtkNq3S5PEdgCUJ07EQ&s",
    },
    {
      "title": "Café Mocha",
      "subtitle": "Freshly brewed with chocolate",
      "rating": 4.5,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7VQJh7ka40x-igYnOoW8UZBFsQylSM_ttzA&s",
    },
    {
      "title": "Espresso Shot",
      "subtitle": "Strong and aromatic flavor",
      "rating": 4.2,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1T6PiFxZ2a8mhX145GtxmWr7T_o8LsTsC9w&s",
    },
    {
      "title": "Iced Latte",
      "subtitle": "Cold and refreshing",
      "rating": 4.8,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ7JeuBhJODHcuTH7QtkNq3S5PEdgCUJ07EQ&s",
    },
  ];
  late List<Photo> photos = [];
  Vendors? vendors;

  @override
  void initState() {
    super.initState();
    vendors = widget.vendor;
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _startAutoScroll();
    // Here will get vendors with packages.
    if(selectedIndex == 0){
      getVendorsPackages();
    }

  }

  void getVendorsPackages() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = {"vendor_id": widget.vendor!.id};
      context.read<VendorsCubit>().loadVendorPackages(queryParams: data);
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return; // ✅ Prevent calling when widget is disposed

      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % images.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  _buildSlidingImageWidget(size),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                  // ✅ Page indicators
                  Positioned(
                    bottom: 12,
                    child: Row(
                      children: List.generate(photos.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 10 : 8,
                          height: _currentPage == index ? 10 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.redAccent
                                : Colors.white70,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: bodyWidget(),
      ),
    );
  }

  Widget bodyWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.vendor!.salonName ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.vendor!.status!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),

                  // child: Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  //   decoration: BoxDecoration(
                  //     color: Colors.green,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Text(
                  //     widget.vendor!.status!,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ),
              ],
            ),
            Text(
              widget.vendor!.description ?? '',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            Text(
              widget.vendor!.fullAddress ?? '',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.web),
                Icon(Icons.call),
                Icon(Icons.directions),
                Icon(Icons.share),
              ],
            ),

            vendors!.availabilities.isNotEmpty ? availabilitiesWidget() : SizedBox.shrink(),

            _categoryListWidget(),

            selectedCategoryItem(selectedIndex),

          ],
        ),
      ),
    );
  }


  Widget availabilitiesWidget() {
    final days = vendors!.availabilities.first.days;
    final timeFrom =  vendors!.availabilities.first.timeFrom!;
    final timeTo =  vendors!.availabilities.first.timeTo!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availabilities',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),

        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Chip(
                  label: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        days[index],
                        style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${formatTime(timeFrom)} - ${formatTime(timeTo)}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  )
                ),
              );
            },
          ),
        ),

        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSlidingImageWidget(Size size) {
    return SizedBox(
      height: size.height / 3.2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // ✅ PageView with horizontal swipe works here
          photos.isNotEmpty
              ? PageView.builder(
            controller: _pageController,
            itemCount: photos.length,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (index) {
              if (mounted) {
                setState(() => _currentPage = index);
              }
            },
            itemBuilder: (context, index) {
              final images = photos;
              return NetworkImageWidget(
                imageUrl: images[index].url!,
                fallbackAsset: ConstantAssets.nuLookLogo,
                borderRadius: 10,
                fit: BoxFit.cover,
                fallbackOpacity: 0.4,
                grayscaleFallback: true,
              );
              // return Image.network(
              //   images[index].url!,
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              // );
            },
          )
              : Center(child: Container(

                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: NetworkImageWidget(
                    imageUrl: vendors!.logoUrl ?? '',
                    fallbackAsset: ConstantAssets.nuLookLogo,
                    borderRadius: 10,
                    fit: BoxFit.fill,
                    fallbackOpacity: 0.4,
                    grayscaleFallback: true,
                   ),
                 ),
            ),
        ],
      ),
    );
  }

  Align floatingActionWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text(
              "Start Cooking",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.blueGrey,
          ),
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
                  if(selectedIndex == 0){
                    getVendorsPackages();
                  }else{
                    vendorServices();
                  }
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

  Widget selectedCategoryItem(int page) {
    switch (page) {
      case 0:
        return vendorPackagesWidget();
      case 1:
        return vendorServices();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return Container();
    }
    return const Text('Screen error');
  }

  Widget _buildSpecialist(String name) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(images[0])),
          SizedBox(height: 8),
          Text(name, style: TextStyle()),
          Text("", style: TextStyle()),
        ],
      ),
    );
  }

  Widget vendorPackagesWidget() {
    return BlocBuilder<VendorsCubit, VendorsState>(
      builder: (context, state) {
        if (state is VendorsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is VendorsPackagesLoaded) {
          final vendorPackages = state.vendorPackages!.packages;
          return Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Text(
                'Packages',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                itemCount: vendorPackages.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Package package = vendorPackages[index];
                  return InkWell(
                    onTap: () {
                      Utils.openModalBottomSheet(context,
                          BridalPackageDialog(package: package , serviceVariation: state.serviceVariationItem),
                          isScrollControlled: true,
                          staticContent: false);
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          // 🔹 Image with curved corners
                          // ClipRRect(
                          //   borderRadius: const BorderRadius.only(
                          //     topLeft: Radius.circular(16),
                          //     bottomLeft: Radius.circular(16),
                          //     bottomRight: Radius.circular(16),
                          //     topRight: Radius.circular(16),
                          //   ),
                          //   child: Image.network(
                          //     "https://e7.pngegg.com/pngimages/490/106/png-clipart-woman-sketch-woman-drawing-salon-face-people.png",
                          //     width: 110,
                          //     height: 110,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          Expanded(
                            flex: 0,
                            child: Container(
                              height: 100,
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: NetworkImageWidget(
                                imageUrl:  package.image ?? '',
                                fallbackAsset: ConstantAssets.nuLookLogo,
                                borderRadius: 10,
                                fit: BoxFit.fill,
                                fallbackOpacity: 0.4,
                                grayscaleFallback: true,
                              ),
                            ),
                          ),
                          // 🔹 Text and Rating section
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    package.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    package.description ?? '',
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 10),

                                  // 🔹 Rating stars
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        "₹ ${package.price?.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: CommonButton(
                                          height: 30,
                                          textStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
                                          title: "Book Now",
                                          onPressed: () {
                                            Utils.openModalBottomSheet(context,
                                                BridalPackageDialog(package: package , serviceVariation: state.serviceVariationItem),
                                                isScrollControlled: true,
                                                staticContent: false);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
        if (state is VendorsError) {
          return NoDataWidget(
            icon: Icons.error,
            title: "No Data found",
            description: state.message,
          );
        }
        return NoDataWidget();
      },
    );
  }

  String formatTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];

    final isPm = hour >= 12;
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;

    return '$formattedHour:$minute ${isPm ? 'PM' : 'AM'}';
  }

  Widget vendorServices() {
    return NoDataWidget();
  }
}
