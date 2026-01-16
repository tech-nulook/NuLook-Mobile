
import 'package:go_router/go_router.dart';
import 'package:nulook_app/Features/OnBoarding/view/onboarding_page.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import '../../Features/about/view/about_main_screen.dart';
import '../../Features/about/view/dynamic_question_screen.dart';
import '../../Features/home/view/advanced_drawer.dart';
import '../../Features/signIn/view/signin_page.dart';
import '../../features/favourite/favourite_screen.dart';
import '../../features/home/view/feeling_section_details.dart';
import '../../features/notification/notifications_screen.dart';
import '../../features/splash/view/splash_page.dart';
import '../../features/vendors/view/salons_page.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: AppRouterConstant.splash,
  // redirect: (context, state) {
  //   final isLoggedIn = false; // read from storage / cubit
  //
  //   if (state.matchedLocation == '/splash') {
  //     return isLoggedIn ? '/home' : '/login';
  //   }
  //   return null;
  // },
  routes: [
    GoRoute(
      path: AppRouterConstant.splash,
      name: AppRouterConstant.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRouterConstant.onBoardingPage,
      name: AppRouterConstant.onBoardingPage,
      builder: (context, state) => const OnBoardingPage(),
    ),
    GoRoute(
      path: AppRouterConstant.signInPage,
      name: AppRouterConstant.signInPage,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: AppRouterConstant.aboutMainScreen,
      name: AppRouterConstant.aboutMainScreen,
      builder: (context, state) => const AboutMainScreen(),
    ),
    GoRoute(
      path: AppRouterConstant.dynamicQuestionScreen,
      name: AppRouterConstant.dynamicQuestionScreen,
      builder: (context, state) {
        return DynamicQuestionScreen.getRouteInstance();
      },
    ),
    GoRoute(
      path: AppRouterConstant.advancedDrawer,
      name: AppRouterConstant.advancedDrawer,
      builder: (context, state) {
        return AdvancedDrawerWidget.getRouteInstance();
      },
    ),
    GoRoute(
      path: AppRouterConstant.feelingSectionDetails,
      name: AppRouterConstant.feelingSectionDetails,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final tabGradient = extra?['tabGradient']; // List<Color>?
        return FeelingSectionDetails(
          tabGradient: tabGradient,
        );
      },
    ),
    GoRoute(
      path: AppRouterConstant.notifications,
      name: AppRouterConstant.notifications,
      builder: (context, state) {
        return NotificationScreen();
      },
    ),
    GoRoute(
      path: AppRouterConstant.favoritesScreen,
      name: AppRouterConstant.favoritesScreen,
      builder: (context, state) {
        return FavoritesScreen();
      },
    ),
    GoRoute(
      path: AppRouterConstant.salonsPage,
      name: AppRouterConstant.salonsPage,
      builder: (context, state) {
        return SalonsPage.getRouteInstance();
      },
    ),


    // GoRoute(
    //   path: AppRouterConstant.mainScreen,
    //   name: AppRouterConstant.mainScreen,
    //   builder: (context, state) {
    //     return MainScreen();
    //   },
    // ),
    // GoRoute(
    //   path: AppRouterConstant.homeScreen,
    //   name: AppRouterConstant.homeScreen,
    //   builder: (context, state) {
    //     return HomeScreen(onTap: (bool p1) {  },);
    //   },
    // ),
    // GoRoute(
    //   path: AppRouterConstant.locationScreen,
    //   name: AppRouterConstant.locationScreen,
    //   builder: (context, state) {
    //     return LocationScreen();
    //   },
    // ),
    // GoRoute(
    //   path: AppRouterConstant.appointmentsScreen,
    //   name: AppRouterConstant.appointmentsScreen,
    //   builder: (context, state) => AppointmentsPage(),
    // ),
    // GoRoute(
    //   path: AppRouterConstant.settingsScreen,
    //   name: AppRouterConstant.settingsScreen,
    //   builder: (context, state) => SettingsScreen(),
    // ),

    // GoRoute(
    //   path: '/details',
    //   name: 'details',
    //   builder: (context, state) {
    //     final String? title = state.extra as String?;
    //     return DetailsScreen(title: title ?? 'No Data');
    //   },
    // ),


  ],
);