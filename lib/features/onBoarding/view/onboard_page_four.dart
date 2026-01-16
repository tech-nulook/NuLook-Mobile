import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/constant/constant_assets.dart';
import '../model/data.dart';
import 'UserListView.dart';

class OnboardPageFour extends StatefulWidget {
  const OnboardPageFour({super.key});

  @override
  _OnboardPageFourState createState() => _OnboardPageFourState();
}

class _OnboardPageFourState extends State<OnboardPageFour> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

        // Positioned.fill(
        //   child: ImageFiltered(
        //       imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2,tileMode: TileMode.repeated),
        //       child: Padding(
        //         padding: const EdgeInsets.all(20),
        //         child: Image.asset( ConstantAssets.onboardImageThree, fit: BoxFit.cover),
        //       )),
        // ),

        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:  Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 200),
              child: Image.asset(
                ConstantAssets.onboardImageThree, // couple image
                fit: BoxFit.fill,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.70,
              ),
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
           // Image.asset('assets/icons/nulook_logo.png', width: 200),
            const Text(
              "Ready to Flex Your NuLook?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Top in.Belong. your journey starts here.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 150),
          ],
        ),
      ],
    );
  }
}
