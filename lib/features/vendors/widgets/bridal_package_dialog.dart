
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/common_button.dart';
import '../../../core/theme/theme_cubit.dart';
import '../model/vendor_packages.dart';

class BridalPackageDialog extends StatefulWidget {
  final  Package package;
  final List<ServiceVariationItem> serviceVariation;
  const BridalPackageDialog({super.key , required this. package , required this.serviceVariation});

  @override
  State<BridalPackageDialog> createState() => _BridalPackageDialogState();
}

class _BridalPackageDialogState extends State<BridalPackageDialog> {
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    widget.serviceVariation[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// IMAGE
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                    bottom: Radius.circular(24),
                  ),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 5),

                /// CONTENT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.package.name!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      bulletText(widget.package.description ?? ""),
                      const SizedBox(height: 5),
                      const Text(
                        "Services",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      bulletText(widget.serviceVariation[0].serviceType ?? ""),
                      const SizedBox(height: 5),
                      bulletText(widget.serviceVariation[0].serviceName ?? ""),
                      const SizedBox(height: 5),
                      bulletText(widget.serviceVariation[0].serviceDescription ?? ""),
                      const SizedBox(height: 5),
                      _servicesGrid(widget.serviceVariation[0].variations),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                /// BOTTOM BUTTON
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                       Text(
                         "₹ ${ widget.package.price!.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CommonButton(
                          title: "BOOK NOW",
                          onPressed: () {
                            // Handle submit action
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget bulletText(String text) {
    return Text(
      "• $text",
      style: const TextStyle(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
    );
  }
  /// SERVICES GRID
  static Widget _servicesGrid(List<Variation> variations) {
    final services = [
      "Hairstyling",
      "Nail",
      "Hair color",
      "Body Glowing",
      "Facial",
      "Spa",
      "Eyebrows",
      "Make up",
      "Retoch",
      "Corner Lashes",
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: variations.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 8,
      ),
      itemBuilder: (_, index) {
        return Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                variations[index].talentType!,
                style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
