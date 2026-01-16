import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import 'package:nulook_app/features/settings/settings_screen.dart';
import '../../appointments/view/appointments_page.dart';
import '../../appointments/view/book_appointment_with_payment.dart';
import '../../location/view/location_screen.dart';
import 'home_screen_new.dart';

class MainScreen extends StatefulWidget {
  final Function(bool) onTap;

  const MainScreen({super.key, required this.onTap});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int counter = 0;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  late final List<Widget> _screens = [
    //context.goNamed(AppRouterConstant.home),
    HomeScreen(onTap: widget.onTap),
    LocationScreen(),
    AppointmentsPage(),
    SettingsScreen(),
    SettingsScreen()
  ];

  Future<void> openHomeScreen(BuildContext context) async {
    final bool? result = await context.pushNamed<bool>(
      AppRouterConstant.homeScreen,
    );

    if (result != null) {
      debugPrint('Received from B: $result');
      context.pop(result);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //  // backgroundColor: Colors.black,
      //   title: const Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text("Hi",
      //           style: TextStyle(
      //               fontSize: 16.0,
      //               fontFamily: 'Montserrat',
      //               fontWeight: FontWeight.w600)),
      //       Text("Ghanashyam Behera",
      //           style: TextStyle(
      //               fontSize: 13.0,
      //               fontFamily: 'Montserrat',
      //               fontWeight: FontWeight.w300))
      //     ],
      //   ),
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) {
      //           return SignInPage();
      //         },
      //       ));
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.all(5.0),
      //       child: Padding(
      //         padding: EdgeInsets.all(2.0),
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.all(Radius.circular(10.0)),//add border radius here
      //           child: Image.network('https://media.licdn.com/dms/image/C5603AQFO2AMNPmxsNg/profile-displayphoto-shrink_800_800/0/1659575612662?e=2147483647&v=beta&t=3FYgJONgUr8N2HtVWUG4OG1uzuN7bymxcSL-SW3nCV4'),//add image location here
      //         ),
      //         // child: CircleAvatar(
      //         //   radius: 10,
      //         //   backgroundImage: NetworkImage(
      //         //       "https://media.licdn.com/dms/image/C5603AQFO2AMNPmxsNg/profile-displayphoto-shrink_800_800/0/1659575612662?e=2147483647&v=beta&t=3FYgJONgUr8N2HtVWUG4OG1uzuN7bymxcSL-SW3nCV4"),
      //         // ),
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //           builder: (context) {
      //             return const HomePage();
      //           },
      //         ));
      //       },
      //       child: const Icon(
      //         Icons.search,
      //         size: 30,
      //       ),
      //     ),
      //     const SizedBox(width: 10),
      //     const Icon(
      //       Icons.notifications_none_outlined,
      //       size: 30,
      //     ),
      //     const SizedBox(width: 10),
      //   ],
      // ),
      bottomNavigationBar: bottomNavigationBarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(left: 0,top: 0, right: 0),
        child: _screens[currentPageIndex],
      ),
    );
  }

  Container bottomNavigationBarWidget() {
    return Container(
      height: Platform.isAndroid ? 70 : 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(1),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(1, 5)),

        ],
      ),
      child: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        elevation: 10,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            // if (currentPageIndex == 4) {
            //   widget.onTap(true);
            // } else {
            //   widget.onTap(false);
            // }
          });
        },
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const FaIcon(FontAwesomeIcons.houseUser),
            icon: const FaIcon(FontAwesomeIcons.houseUser, color: Colors.grey),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: const FaIcon(FontAwesomeIcons.locationDot),
            icon: const FaIcon(
              FontAwesomeIcons.locationDot,
              color: Colors.grey,
            ),
            label: 'Location',
          ),
          NavigationDestination(
            selectedIcon: const FaIcon(FontAwesomeIcons.solidCalendarDays),
            icon: const FaIcon(
              FontAwesomeIcons.solidCalendarDays,
              color: Colors.grey,
            ),
            label: 'Appoints',
            enabled: true,
          ),
          NavigationDestination(
            selectedIcon: const FaIcon(FontAwesomeIcons.fileFragment),
            icon: const FaIcon(
              FontAwesomeIcons.fileFragment,
              color: Colors.grey,
            ),
            label: 'Reports',
          ),
          NavigationDestination(
            selectedIcon: const FaIcon(FontAwesomeIcons.gear),
            icon: const FaIcon(FontAwesomeIcons.gear, color: Colors.grey),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Header
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Hi,", style: TextStyle(color: Colors.white70)),
                Text("Jerry Milona"),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.white),
            ),
            const Icon(Icons.monetization_on, color: Colors.amber),
            const SizedBox(width: 4),
            const Text(
              "1.5K",
              style: TextStyle(color: Colors.amber, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget showChildView(int page) {
    switch (page) {
      case 0:
        return HomeScreen(onTap: widget.onTap);
      case 1:
        return const LocationScreen(); //LocationPage
      case 2:
        return const AppointmentsPage();
      case 3:
        return SettingsScreen();
      case 4:
        return SettingsScreen();
    }
    return const Text('Screen error');
  }
}
