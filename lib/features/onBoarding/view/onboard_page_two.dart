import 'package:flutter/material.dart';
import 'package:nulook_app/core/constant/constant_assets.dart';

import '../../../common/widgets/network_image_widget.dart';
import '../model/data.dart';
import 'UserListView.dart';

class OnboardPageTwo extends StatefulWidget {
  const OnboardPageTwo({super.key});

  @override
  _OnboardPageTwoState createState() => _OnboardPageTwoState();
}

class _OnboardPageTwoState extends State<OnboardPageTwo> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
        fit: StackFit.expand,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ClipRect(
              child: Image.asset(
                ConstantAssets.onboardImageOne,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black, Colors.black],
                stops: [0.0, 0.9, 0.9],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.repeated,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(ConstantAssets.nuLogo, width: 200),
              const Text(
                "Glow Now. Earn Always",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25,  color: Colors.white,fontWeight: FontWeight.bold),
              ),
              const Text(
                "Every booking gives you NuCoins. Every vibe unlocks rewards",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 150)
            ],
          ),
        ],
      );
  }
}
