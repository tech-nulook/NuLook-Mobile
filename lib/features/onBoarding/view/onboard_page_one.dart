import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constant/constant_assets.dart';
import '../model/data.dart';
import 'UserListView.dart';

class OnboardPageOne extends StatefulWidget {
  const OnboardPageOne({super.key});

  @override
  _OnboardPageOneState createState() => _OnboardPageOneState();
}

class _OnboardPageOneState extends State<OnboardPageOne> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;
      await Future.delayed(Duration.zero);
      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 15, _scrollController1,);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 10, _scrollController2,);
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds, ScrollController scrollController) {
    scrollController.animateTo(direction, duration: Duration(seconds: seconds), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: UserListView(
                  scrollController: _scrollController1,
                  images: movies1,
                ),
              ),
              Expanded(
                child: UserListView(
                  scrollController: _scrollController2,
                  images: movies2,
                ),
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                stops: [0.0, 0.8],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.mirror,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(ConstantAssets.nuLogo,width: 200),
              const Text(
                "Glow Now. Earn Always.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Every booking gives you NuCoins. Every vibe unlocks rewards.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 100)
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }
}
