
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nulook_app/common/widgets/network_image_widget.dart';
import 'package:nulook_app/core/constant/constant_assets.dart';
import 'package:nulook_app/core/routers/app_navigator.dart';
import 'package:nulook_app/features/settings/view/about_us_screen.dart';
import 'package:nulook_app/features/settings/view/invite_friends_screen.dart';
import 'package:nulook_app/features/settings/view/privacy_policy_screen.dart';
import 'package:nulook_app/features/settings/view/terms_conditions_screen.dart';

import '../../Features/about/view/about_main_screen.dart';
import '../../Features/signIn/view/signin_page.dart';
import '../../common/bloc/user_pref_cubit.dart';
import '../../core/routers/app_router_constant.dart';
import '../../core/storage/secure_storage_constant.dart';
import '../../core/storage/secure_storage_helper.dart';
import '../../core/storage/shared_preferences_helper.dart';
import '../../core/theme/theme_cubit.dart';
import '../payments/view/payment_history.dart';
import '../payments/view/payment_method.dart';
import '../signIn/view/change_password_screen.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? userName = "XXXXXXXX XXXX";
  String? userEmail = "XXXX123@XXX.XXX";
  String? userPicture = "";
  String? phoneNumber = "91 XXXX XXXX XX";
  String? gender = "";
  String? location = "";

  @override
  void initState() {
    loadStoredData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(13),
          child: Column(
            children: [
      
              /// Profile Card
              BlocBuilder<UserPrefCubit, UserPrefState>(
                builder: (context, state) {
                  if (!state.isLoaded) return const CircularProgressIndicator();
                  return _profileCard(context, state);
                },
              ),
      
              const SizedBox(height: 24),
              /// Preferences
              _sectionTitle('Preferences'),
              _themeSwitchTile(context),
      
              /// Account
              _sectionTitle('Account'),
              _settingsTile(
                icon: Icons.payment,
                title: 'Payment Method',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
                  );
                },
              ),
              _settingsTile(
                icon: Icons.history,
                title: 'Payment History',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaymentHistoryScreen()),
                  );
                },
              ),
              _settingsTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                  );
                },
              ),
              _settingsTile(
                icon: Icons.group_add_outlined,
                title: 'Invite Friends',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => InviteFriendsScreen()),
                  );
                },
              ),
      
              /// Support
              _sectionTitle('Support'),
              _settingsTile(
                icon: Icons.help_outline,
                title: 'FAQs',
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.push(AppRouterConstant.dynamicQuestionScreen);
                  });
                },
              ),
              _settingsTile(
                icon: Icons.info_outline,
                title: 'About Us',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AboutUsScreen()),
                  );
                },
              ),
              _settingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                  );
                },
              ),
              _settingsTile(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TermsConditionsScreen()),
                  );
                },
              ),
      
      
              /// Logout
              _settingsTile(
                icon: Icons.logout,
                title: 'Logout',
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: () => _showLogoutConfirmationDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /// Profile Card Widget
  Widget _profileCard(BuildContext context, UserPrefState state) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            /// Profile Image
            NetworkImageWidget(
              imageUrl: state.userPicture,
              height: 80,
              width: 80,
              borderRadius: 50,
              fit: BoxFit.fitWidth,
              fallbackAsset: ConstantAssets.nuLookLogo,
              grayscaleFallback: true,
            ),
            const SizedBox(width: 5),
            /// User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    state.userName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    state.userEmail,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    state.phoneNumber,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                bool? isSkip = true;
                // Navigate to edit profile page
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  if (!context.mounted) return;
                  final bool? result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AboutMainScreen.getRouteInstance(isSkip, state.userName, state.userEmail, state.userPicture, state.phoneNumber, state.gender),
                    ),
                  );
                  if (result == true) {
                     loadStoredData();
                  }
                });
              },
              child: const Icon(Icons.edit, size: 20)),
          ],
        ),
      ),
    );
  }

  /// Section Title
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  /// Settings Tile
  Widget _settingsTile({
    required IconData icon,
    required String title,
    Color? iconColor,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
  /// Theme Switch
  Widget _themeSwitchTile(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return ListTile(
      leading: const Icon(Icons.dark_mode_outlined),
      title: const Text('Dark Theme'),
      trailing: Switch(
        value: isDark, // connect with ThemeCubit
        onChanged: (value) {
          cubit.toggleTheme();
        },
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
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
      await SharedPreferencesHelper.instance.remove(SecureConstant.userId);
      await SharedPreferencesHelper.instance.remove(SecureConstant.userProfileData);
      await SecureStorageHelper.instance.deleteData(SecureConstant.accessTokenKey);
      await SecureStorageHelper.instance.deleteAll();
      await SharedPreferencesHelper.instance.clear();
      await SharedPreferencesHelper.instance.setBool(SecureConstant.onboardingCompleted, true);
      // Perform logout operation here
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppNavigator.goNamed(AppRouterConstant.signInPage);
      });
    }
  }


  // Async method to load SharedPreferences data
  Future<void> loadStoredData() async {
    try {
      final userData = await SharedPreferencesHelper.instance.getObject(
        SecureConstant.userProfileData,);
      if (!mounted) return; // important safety check
      setState(() {
        userPicture = userData['picture'] ?? "https://cdn-icons-png.freepik.com/512/6218/6218538.png";
        userName = userData['name'] ?? "";
        userEmail = userData['email'] ?? "";
        phoneNumber = userData['phone_number'] ?? "";
        gender = userData['gender'] ?? "";
        location = userData['location'] ?? "";
      });
      debugPrint("userPicture: $userPicture");
      debugPrint("userName: $userName");
      debugPrint("userEmail: $userEmail");
      debugPrint("phoneNumber: $phoneNumber");
      debugPrint("gender: $gender");
      debugPrint("location: $location");
    } catch (e) {
      debugPrint("$e");
    }
  }
}