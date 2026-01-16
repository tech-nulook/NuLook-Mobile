import 'package:flutter/material.dart';

import '../../../core/constant/constant_assets.dart';
import '../model/data.dart';
import 'UserListView.dart';

class OnboardPageThree extends StatefulWidget {
  const OnboardPageThree({super.key});

  @override
  _OnboardPageThreeState createState() => _OnboardPageThreeState();
}

class _OnboardPageThreeState extends State<OnboardPageThree> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //Image.asset(ConstantAssets.onboardImageTwoA, fit: BoxFit.cover),
        // Image.asset(ConstantAssets.onboardImageTwoB, fit: BoxFit.cover),
        // Image.asset(ConstantAssets.onboardImageTwoC, fit: BoxFit.cover),
        // Container(
        //   clipBehavior: Clip.antiAlias,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(10)),
        //   ),
        //   child: Stack(
        //     children: [
        //       Image.asset(
        //         ConstantAssets.onboardImageTwoA,
        //         fit: BoxFit.cover,
        //         width: double.infinity,
        //         height: MediaQuery.of(context).size.height * 0.7,
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         left: 0,
        //         right: 0,
        //         child: Image.asset(
        //           ConstantAssets.onboardImageTwoB,
        //           fit: BoxFit.cover,
        //           width: 100,
        //           height: 100,
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         left: 0,
        //         right: 0,
        //         child: Image.asset(
        //           ConstantAssets.onboardImageTwoC,
        //           fit: BoxFit.cover,
        //           width: 100,
        //           height: 100,
        //         ),
        //       ),
        //
        //     ],
        //   )
        // ),
        Container(
         // height: MediaQuery.of(context).size.height * 0.7,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// 🔹 Background Image
              Image.asset(
                ConstantAssets.onboardImageTwoA, // dark background
                fit: BoxFit.cover,
              ),

              /// 🔹 Golden Light Overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    radius: 0.8,
                    colors: [
                      Color(0x66FFD700), // golden glow
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              /// 🔹 Couple Image
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: Image.asset(
                    ConstantAssets.onboardImageTwoB, // couple image
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 200),
                  child: Image.asset(
                    ConstantAssets.onboardImageTwoC, // couple image
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                ),
              ),

            ],
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
