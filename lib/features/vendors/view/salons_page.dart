import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nulook_app/features/vendors/view/salons_details_page.dart';
import '../../../features/vendors/model/vendor.dart';
import '../../../common/widgets/network_image_widget.dart';
import '../../../core/constant/constant_assets.dart';
import '../bloc/vendors_cubit.dart';

class SalonsPage extends StatefulWidget {
  const SalonsPage({super.key});

  static Widget getRouteInstance() => MultiBlocProvider(
    providers: [BlocProvider(create: (context) => VendorsCubit())],
    child: SalonsPage(),
  );

  @override
  State<SalonsPage> createState() => _SalonsPageState();
}

class _SalonsPageState extends State<SalonsPage> {
  final TextEditingController _searchController = TextEditingController();

  // List of items
  final List<String> items = [
    " All ",
    "Haircuts",
    "Make up",
    "Massage",
    "Skin care",
    "None",
  ];

  // Track selected index
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VendorsCubit>().loadVendors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 50,
          color: Colors.transparent,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.align_horizontal_left),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          _categoryListWidget(),
          BlocBuilder<VendorsCubit, VendorsState>(
            builder: (context, state) {
              if (state is VendorsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is VendorsLoaded) {
                final List<Vendors> vendors = state.vendor?.vendors ?? [];
                return _searchResultItems(vendors);
              }
              if (state is VendorsError) {
                return Text(state.message);
              }
              return Container();
            },
          ),
        ],
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
          itemCount: items.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
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
                    items[index],
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

  Widget _searchResultItems(List<Vendors> vendorList) {
    final List<Vendors> reversedItems = vendorList.reversed.toList();
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: reversedItems.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        addAutomaticKeepAlives: true,
        cacheExtent: 100.0,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final Vendors item = reversedItems[index]; // ✅ FIX
          return _buildVendorWidgetCard(context, item);
        },
      ),
    );
  }

  Widget _buildVendorWidgetCard(BuildContext context, Vendors item) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SalonsDetailsPage(vendor: item);
            },
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
            //     item["image"].toString(),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: NetworkImageWidget(
                  imageUrl: item.logoUrl ?? '',
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
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.salonName ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.description ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.salonFor ?? "",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),

                    // 🔹 Rating stars
                    Row(
                      children: [
                        // Icon(
                        //   Icons.star,
                        //   color: Colors.amber.shade600,
                        //   size: 20,
                        // ),
                        // const SizedBox(width: 4),
                        // Text(
                        //   item.pocName.toString(),
                        //   style: const TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.status.toString().toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
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
  }


}
