import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nulook_app/Features/location/cubit/location_cubit.dart';
import 'package:nulook_app/core/constant/constant_data.dart';
import 'package:nulook_app/core/cubit/image/image_cubit.dart';
import 'package:nulook_app/core/storage/secure_storage_constant.dart';
import 'package:nulook_app/core/storage/secure_storage_helper.dart';
import 'package:nulook_app/core/storage/shared_preferences_helper.dart';
import 'package:nulook_app/core/theme/theme_cubit.dart';
import 'package:nulook_app/features/vendors/bloc/vendors_cubit.dart';
import 'package:nulook_app/features/signIn/bloc/sign_in_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Core/Theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/routers/app_router.dart';
import 'common/bloc/user_pref_cubit.dart';
import 'common/utils/notification_utility.dart';
import 'core/location/location_stream.dart';
import 'core/theme/app_theme.dart';
import 'features/about/bloc/signup_cubit.dart';
import 'features/home/bloc/home_cubit.dart';
import 'features/splash/view/splash_page.dart';
import 'features/vendors/view/salons_page.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = SharedPreferencesHelper.instance;
  await prefs.init();
  await initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserPrefCubit(prefs)..loadUserData(),
        ),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => ImageCubit()),
        BlocProvider(create: (_) => LocationCubit()),
        BlocProvider(create: (_) => SignInCubit()),
        BlocProvider(create: (_) => VendorsCubit()),
        BlocProvider(create: (_) => HomeCubit()),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> initializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocationStream.requestPermission();
  await clearSecureStorageOnFreshInstall();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: transparentColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.whiteColor,
      systemNavigationBarDividerColor: transparentColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //hide only the bottom navigation bar, but keep the status bar visible:
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ], // only show status bar
  );
  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  FlutterSecureStorage(aOptions: getAndroidOptions());
}

Future<void> clearSecureStorageOnFreshInstall() async {
  final prefs = await SharedPreferences.getInstance();
  bool? wasInstalled = prefs.getBool("wasInstalled");
  if (wasInstalled == null) {
    // Fresh install → clear secure storage
    await SecureStorageHelper.instance.deleteAll();
    // Mark as installed
    await prefs.setBool("wasInstalled", true);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initializeNotifications();
    super.initState();
  }

  Future<void> initializeNotifications() async {
    await NotificationUtility.instance.setUpNotificationService(
      navigatorKey.currentContext ?? context,
    );
    await NotificationUtility.instance.getDeviceToken().then((token) async {
      // You can send the token to your server or use it as needed
      debugPrint("Device FCM Token: $token");
      await SharedPreferencesHelper.instance.setString(
        SecureConstant.fcmToken,
        token!,
      );
    });

    await NotificationUtility.instance.initializeBadge();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignupCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeInitial>(
        builder: (context, state) {
          return MaterialApp.router(
           // navigatorKey: navigatorKey,
            title: ConstantData.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            routerConfig: appRouter,

            //home: SplashPage(),
          );
        },
      ),
    );
  }
}
