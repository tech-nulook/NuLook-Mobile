
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import 'package:nulook_app/features/home/model/feeltoday.dart';
import 'package:nulook_app/features/home/widgets/feeling_card.dart';


class FeelingItem {
  final String imageUrl;
  final String title;
  final String subtitle;

  const FeelingItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}

class FeelingsSection extends StatefulWidget {
  final List<Color>? tabGradient;
  final bool? isHomeNava;
  final List<FeelToday>?  feelings;
  const FeelingsSection( {super.key , this.tabGradient , this.isHomeNava,  this.feelings});

  @override
  State<FeelingsSection> createState() => _FeelingsSectionState();
}

class _FeelingsSectionState extends State<FeelingsSection> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final List<FeelingItem> feelingsList = [
    FeelingItem(
      imageUrl:
      "https://images.unsplash.com/photo-1506126613408-eca07ce68773",
      title: "Fresh",
      subtitle: "I want to feel clean,\nlight, and reset.",
    ),
    FeelingItem(
      imageUrl:
      "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
      title: "Confident",
      subtitle: "I want to feel sharp and\nready.",
    ),
    FeelingItem(
      imageUrl:
      "https://images.unsplash.com/photo-1506126613408-eca07ce68773",
      title: "Relaxed",
      subtitle: "I want to feel calm and\npeaceful.",
    ),
    FeelingItem(
      imageUrl:
      "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
      title: "Energized",
      subtitle: "I want to feel active and\nmotivated.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: "How do you want to feel today?",
          onTap: () {},
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.feelings!.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.feelings![index];

              return Padding(
                padding: EdgeInsets.only(
                  right: index == widget.feelings!.length - 1 ? 0 : 16,
                ),
                child: FeelingCard(
                  isHomeNava : widget.isHomeNava,
                  tabGradient : widget.tabGradient,
                  imageUrl: item.image ?? '',
                  title: item.name!,
                  subtitle: item.description!,
                  onTap: () {
                    context.push(
                      AppRouterConstant.feelingSectionDetails,
                      extra: {
                        'tabGradient': widget.tabGradient,
                      }
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader({required String title, required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "See All",
            style: TextStyle(
              color: Color(0xFFFF4D4D),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}


