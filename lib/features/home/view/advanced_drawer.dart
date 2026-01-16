import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nulook_app/Features/signIn/view/signin_page.dart';
import 'package:nulook_app/core/constant/constant_assets.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import 'package:nulook_app/core/storage/secure_storage_constant.dart';
import 'package:nulook_app/core/storage/shared_preferences_helper.dart';
import 'package:nulook_app/features/settings/faqs.dart';
import '../../../Features/Home/view/main_screen.dart';
import '../../../Features/about/view/dynamic_question_screen.dart';
import '../../../Features/signIn/bloc/sign_in_cubit.dart';
import '../../../common/bloc/user_pref_cubit.dart';
import '../../../common/widgets/glass_icon_button.dart';
import '../../../common/widgets/network_image_widget.dart';
import '../../../features/vendors/view/salons_page.dart';
import '../../../common/widgets/notification_badge_Icon.dart';
import '../../../core/storage/secure_storage_helper.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../payments/view/payment_history.dart';
import '../../payments/view/payment_method.dart';
import '../../settings/view/about_us_screen.dart';
import '../../settings/view/invite_friends_screen.dart';
import '../../signIn/view/change_password_screen.dart';

class AdvancedDrawerWidget extends StatefulWidget {
  const AdvancedDrawerWidget({super.key});

  static Widget getRouteInstance() => MultiBlocProvider(
    providers: [BlocProvider(create: (context) => SignInCubit())],
    child: AdvancedDrawerWidget(),
  );

  @override
  State<AdvancedDrawerWidget> createState() => _AdvancedDrawerWidgetState();
}

class _AdvancedDrawerWidgetState extends State<AdvancedDrawerWidget> {
  final _advancedDrawerController = AdvancedDrawerController();
  dynamic userData;
  String? userName = "";
  String? userEmail = "";
  String? userPicture = "";
  String? phoneNumber = "";
  String? gender = "";
  String? location = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> loadStoredData() async {
    try {
      final userData = await SharedPreferencesHelper.instance.getObject(
        SecureConstant.userProfileData,
      );
      if (!mounted) return; // important safety check
      setState(() {
        userPicture =
            userData['picture'] ??
            "https://cdn-icons-png.freepik.com/512/6218/6218538.png";
        userName = userData['name'] ?? "";
        userEmail = userData['email'] ?? "";
        phoneNumber = userData['phone_number'] ?? "";
        gender = userData['gender'] ?? "";
        location = userData['location'] ?? "";
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return AdvancedDrawer(
      drawerCloseSemanticLabel: 'close drawer',
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.transparent, Colors.transparent],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      disabledGestures: true,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      childDecoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.5), // Shadow color
            spreadRadius: 10, // How much the shadow spreads
            blurRadius: 20, // How soft the shadow looks
            offset: Offset(1, 1), // Horizontal & vertical movement
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      drawer: buildDrawerWidget(context, isDark, cubit),
      child: Scaffold(
        // appBar: AppBar(
        //   title: BlocBuilder<UserPrefCubit, UserPrefState>(
        //     builder: (context, state) {
        //       return Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "Hi",
        //             style: TextStyle(
        //               fontSize: 16.0,
        //               fontFamily: 'Montserrat',
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //           Text(
        //             state.userName,
        //             style: TextStyle(
        //               fontSize: 13.0,
        //               fontFamily: 'Montserrat',
        //               fontWeight: FontWeight.w300,
        //             ),
        //           ),
        //         ],
        //       );
        //     },
        //   ),
        //   leading: IconButton(
        //     onPressed: _handleMenuButtonPressed,
        //     icon: ValueListenableBuilder<AdvancedDrawerValue>(
        //       valueListenable: _advancedDrawerController,
        //       builder: (_, value, __) {
        //         return BlocBuilder<UserPrefCubit, UserPrefState>(
        //           builder: (context, state) {
        //             return AnimatedSwitcher(
        //               duration: Duration(milliseconds: 250),
        //               child: Semantics(
        //                 label: 'Menu',
        //                 onTapHint: 'expand drawer',
        //                 child: ClipRRect(
        //                   borderRadius: BorderRadius.circular(50),
        //                   child: NetworkImageWidget(
        //                     imageUrl: state.userPicture,
        //                     height: 80,
        //                     width: 80,
        //                     borderRadius: 50,
        //                     fit: BoxFit.fitWidth,
        //                     fallbackAsset: ConstantAssets.nuLookLogo,
        //                     grayscaleFallback: true,
        //                   ),
        //                 ),
        //               ),
        //               // child: Icon(
        //               //   value.visible ? Icons.clear : Icons.menu,
        //               //   key: ValueKey<bool>(value.visible),
        //               // ),
        //             );
        //           },
        //         );
        //       },
        //     ),
        //   ),
        //   actions: [
        //     InkWell(
        //       onTap: () {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (context) {
        //               return SalonsPage.getRouteInstance();
        //             },
        //           ),
        //         );
        //       },
        //       child: const FaIcon(FontAwesomeIcons.magnifyingGlass),
        //     ),
        //     const SizedBox(width: 10),
        //     //const FaIcon(FontAwesomeIcons.bell),
             //NotificationBadgeIcon(count: 3),
        //     const SizedBox(width: 10),
        //   ],
        // ),
        body: MainScreen(
          onTap: (isBool) {
            isBool ? _handleMenuButtonPressed() : null;
          },
        ),

      ),
    );
  }

  Future<void> openMainScreen(BuildContext context) async {
    final String? resultFromC = await context.pushNamed<String>(
      AppRouterConstant.mainScreen,
    );

    if (resultFromC != null) {
      debugPrint('A received: $resultFromC');
    }
  }

  SafeArea buildDrawerWidget(
    BuildContext context,
    bool isDark,
    ThemeCubit cubit,
  ) {
    return SafeArea(
      child: ListTileTheme(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserPrefCubit, UserPrefState>(
              builder: (context, state) {
                if (!state.isLoaded) return const CircularProgressIndicator();
                return buildProfileViewWidget(state ,isDark);
              },
            ),

            Divider(color: Colors.grey.shade800, height: 0.1),

            ListTile(
              onTap: () {
                _advancedDrawerController.hideDrawer();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
                );
              },
              leading: const FaIcon(FontAwesomeIcons.creditCard),
              title: Text(
                'Payment Method',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            ListTile(
              onTap: () {
                _advancedDrawerController.hideDrawer();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentHistoryScreen()),
                );
              },
              leading: FaIcon(FontAwesomeIcons.history),
              title: Text(
                'Payment History',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            ListTile(
              onTap: () {
                _advancedDrawerController.hideDrawer();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                );
              },
              leading: FaIcon(FontAwesomeIcons.userLock),
              title: Text(
                'Change password',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            ListTile(
              onTap: () {
                _advancedDrawerController.hideDrawer();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InviteFriendsScreen()),
                );
              },
              leading: FaIcon(FontAwesomeIcons.users),
              title: Text(
                'Invite Friends',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            ListTile(
              onTap: () {
                _advancedDrawerController.hideDrawer();
                // Navigator.of(
                //   context,
                // ).push(MaterialPageRoute(builder: (context) => DynamicQuestionScreen()));
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.goNamed(AppRouterConstant.dynamicQuestionScreen);
                });
              },
              leading: FaIcon(FontAwesomeIcons.question),
              title: Text(
                'FAQs',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            ListTile(
              onTap: () {
                _advancedDrawerController.hideDrawer();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
              leading: FaIcon(FontAwesomeIcons.circleInfo),
              title: Text(
                'About Us',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            ListTile(
              onTap: () => _showLogoutConfirmationDialog(),
              leading: FaIcon(FontAwesomeIcons.rightFromBracket),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Spacer(),

            DefaultTextStyle(
              style: TextStyle(fontSize: 12, color: Colors.white),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.light_mode),
                        Switch(
                          value: isDark,
                          onChanged: (_) => cubit.toggleTheme(),
                        ),
                        const Icon(Icons.dark_mode),
                      ],
                    ),

                    Text(
                      'Terms of Service | Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                      ),
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

  Padding buildProfileViewWidget(UserPrefState state, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        spacing: 2,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              NetworkImageWidget(
                imageUrl: state.userPicture,
                height: 100,
                width: 100,
                borderRadius: 50,
                fit: BoxFit.fitWidth,
                fallbackAsset: ConstantAssets.nuLookLogo,
                grayscaleFallback: true,
              ),
              Row(
                children: [
                  GlassIconButton(
                    icon: Icons.notifications_none,
                    isDecoration: true,
                    showDot: true,
                    onTap: () {
                      context.push(AppRouterConstant.notifications);
                    },
                  ),
                  const SizedBox(width: 12),
                  GlassIconButton(
                    icon: Icons.favorite_border,
                    isDecoration: true,
                    onTap: () {
                      context.push(AppRouterConstant.favoritesScreen);
                    },
                  ),
                ],
              ),
            ],
          ),
          Text(
            state.userName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Text(
            state.userEmail,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            state.phoneNumber,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      _advancedDrawerController.hideDrawer();
      await SharedPreferencesHelper.instance.remove(SecureConstant.userId);
      await SecureStorageHelper.instance.deleteData(
        SecureConstant.accessTokenKey,
      );
      await SecureStorageHelper.instance.deleteAll();
      await SharedPreferencesHelper.instance.clear();
      await SharedPreferencesHelper.instance.setBool(
        SecureConstant.onboardingCompleted,
        true,
      );
      // Perform logout operation here
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed(AppRouterConstant.signInPage);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => const SignInPage()),
        // );
      });
    }
  }

  @override
  void dispose() {
    _advancedDrawerController.dispose();
    super.dispose();
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
