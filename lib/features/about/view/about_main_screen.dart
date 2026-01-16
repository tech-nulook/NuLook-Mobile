import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:nulook_app/core/routers/app_router_constant.dart';
import 'package:nulook_app/core/storage/secure_storage_constant.dart';
import 'package:nulook_app/core/storage/shared_preferences_helper.dart';
import 'package:nulook_app/features/about/bloc/signup_cubit.dart';
import 'package:nulook_app/features/settings/settings_screen.dart';

import '../../../Features/home/view/advanced_drawer.dart';
import '../../../common/app_snackbar.dart';
import '../../../common/bloc/user_pref_cubit.dart';
import '../../../common/common_button.dart';
import '../../../core/cubit/image/image_cubit.dart';
import 'about_your_details.dart';
import 'dynamic_question_screen.dart';

class AboutMainScreen extends StatefulWidget {
  final bool? isSkip;
  final String? userName;
  final String? userEmail;
  final String? userPicture;
  final String? phoneNumber;
  final String? gender;

  const AboutMainScreen({
    super.key,
    this.isSkip = false,
    this.userName = "",
    this.userEmail = "",
    this.userPicture = "",
    this.phoneNumber = "",
    this.gender = ""});

  static Widget getRouteInstance(bool? isSkip, String? userName, String? userEmail, String? userPicture, String? phoneNumber, String? gender) {

    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => SignupCubit())],
      child: AboutMainScreen(
        isSkip: isSkip,
        userName: userName,
        userEmail: userEmail,
        userPicture: userPicture,
        phoneNumber: phoneNumber,
        gender: gender
      ),
    );
  }

  @override
  State<AboutMainScreen> createState() => _AboutMainScreenState();
}

class _AboutMainScreenState extends State<AboutMainScreen> {
  String selectedGender = '';
  DateTime selectedDate = DateTime(2000, 1, 1);
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  EasyDatePickerController controller = EasyDatePickerController();
  bool _isLoading = false;
  String? profileImageUrl = '';

  @override
  void initState() {
    final storedPhone = SharedPreferencesHelper.instance.getString(SecureConstant.phoneNumber);

    debugPrint("✅ Phone number from prefs: $storedPhone");

    final phoneToShow = phoneController.text = (widget.phoneNumber != null && widget.phoneNumber!.isNotEmpty)
        ? widget.phoneNumber!
        : (storedPhone ?? '');
    phoneController.text = phoneToShow;
    nameController.text = widget.userName ?? '';
    emailController.text = widget.userEmail ?? '';
    profileImageUrl = widget.userPicture;
    setState(() {
      selectedGender = widget.gender!;
    });
    super.initState();
  }

  Future getUserDetails() async {

    // // TODO: implement initState
    // widget.userName != null ? nameController.text = widget.userName! : nameController.text = '';
    // widget.userEmail != null ? emailController.text = widget.userEmail! : emailController.text = '';
    // widget.phoneNumber != null ? phone : phoneController.text = phone;
    // setState(() {
    //   widget.userPicture != null ? profileImageUrl = widget.userPicture : profileImageUrl = '';
    //   phoneController.text = phone;
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 InkWell(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new_outlined),
                      SizedBox(width: 10),
                      const Text(
                        "About you",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(child: Container()),
                      !widget.isSkip! ? InkWell(
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.goNamed(AppRouterConstant.advancedDrawer);
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (context) =>  AdvancedDrawerWidget.getRouteInstance(),  //AdvancedDrawerWidget
                            //   ),
                            // );
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('Skip'),
                        ),
                      ) : const SizedBox(),
                    ],
                  ),
                ) ,
                const SizedBox(height: 15),
                profilePickWidget(
                  title: 'Take selfie / upload your profile picture ?',
                  subTitle: 'Set your picture',
                  items: null,
                  selectedIndex: null,
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.white70,
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.white70,
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.email, color: Colors.white70),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Text(
                  "Your Gender",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    genderCard("Male", Icons.male),
                    const SizedBox(width: 10),
                    genderCard("Female", Icons.female),
                  ],
                ),
                horizentalDatePicker(),
                BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupFailure) {
                      AppSnackBar.showError(context, state.errorMessage);
                    } else if (state is SignupSuccess) {
                      context.read<UserPrefCubit>().saveUserData(
                        userName: state.signup.name,
                        userEmail: state.signup.email,
                        phoneNumber: state.signup.phoneNumber,
                        userPicture: state.signup.picture,
                        gender: state.signup.gender,
                        location: state.signup.location,
                      );
                      if(widget.isSkip!){
                       AppSnackBar.showSuccess(context, 'Successful! Updated...');
                       Navigator.of(context).pop(true);
                      } else {
                        AppSnackBar.showSuccess(context, 'Signup Successful! Welcome, ${state.signup.name}');
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.goNamed(AppRouterConstant.dynamicQuestionScreen);
                        });
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) => DynamicQuestionScreen.getRouteInstance(),
                        //   ),
                        // );
                      }
                    } else if (state is FileUploadSuccess) {
                      debugPrint("Profile picture uploaded successfully: ${state.data}",);
                      setState(() {
                        profileImageUrl = state.data;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is SignupLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    }
                    return CommonButton(
                      title: "Continue",
                      isLoading: _isLoading,
                      onPressed: () => onContinuePressed(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onContinuePressed() async {
    setState(() => _isLoading = true);
    // Simulate API call or delay
    await Future.delayed(const Duration(seconds: 0));
    setState(() => _isLoading = false);

    final errorMessage = validateUserDetails(
      name: nameController.text,
      email: emailController.text,
      gender: selectedGender,
      dob: selectedDate,
      phoneNumber: phoneController.text,
    );

    if (errorMessage != null) {
      debugPrint(errorMessage);
      // Show error to user
      if (mounted) {
        AppSnackBar.showError(context, errorMessage);
      }
    } else {
      debugPrint("Validation Success!");
      final dobFormatted = DateFormat('yyyy-MM-dd').format(selectedDate);
      final genderValue = selectedGender;
      final nameValue = nameController.text;
      final emailValue = emailController.text;
      final phoneValue = phoneController.text;
      final userDetails = {
        "name": nameValue,
        "phone_number": SharedPreferencesHelper.instance.getString(SecureConstant.phoneNumber) ?? phoneValue,
        "email": emailValue,
        "gender": genderValue,
        "dob": dobFormatted,
        "location": "Bengaluru,Karnataka,India",
        "picture": profileImageUrl ?? '',
      };
      // Proceed to next screen or API call
      if (mounted) {
        context.read<SignupCubit>().signUpUser(userDetails);
      }
    }
  }

  // Don't forget to dispose the controller when it's no longer needed.
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget genderCard(String gender, IconData icon) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade900 : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.redAccent : Colors.grey.shade200,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.redAccent : Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? Colors.redAccent : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget horizentalDatePicker() {
    return EasyTheme(
      data: EasyTheme.of(context).copyWith(
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          } else if (states.contains(WidgetState.pressed)) {
            return Colors.transparent;
          }
          return Colors.transparent;
        }),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.grey;
          } else if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return Colors.grey;
        }),
        dayBorder: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide(color: Colors.red, width: 2);
          } else if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: Colors.grey, width: 1);
          }
          return BorderSide(color: Colors.grey.shade900, width: 1);
        }),

        // currentDayMiddleElementStyle: WidgetStateProperty.resolveWith((states){
        //   if (states.contains(WidgetState.selected)) {
        //     return TextStyle(color: Colors.grey);
        //   } else if (states.contains(WidgetState.disabled)) {
        //     return TextStyle(color: Colors.grey);
        //   }
        //   return TextStyle(color: Colors.grey);
        // }),
        dayTopElementStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(color: Colors.grey);
          } else if (states.contains(WidgetState.disabled)) {
            return TextStyle(color: Colors.grey);
          }
          return TextStyle(color: Colors.grey);
        }),
        dayBottomElementStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(color: Colors.grey);
          } else if (states.contains(WidgetState.disabled)) {
            return TextStyle(color: Colors.grey);
          }
          return TextStyle(color: Colors.grey);
        }),

        // dayMiddleElementStyle: WidgetStateProperty.resolveWith((states){
        //   if (states.contains(WidgetState.selected)) {
        //     return TextStyle(color: Colors.grey);
        //   } else if (states.contains(WidgetState.disabled)) {
        //     return TextStyle(color: Colors.grey);
        //   }
        //   return TextStyle(color: Colors.grey);
        // }),
      ),
      child: EasyDateTimeLinePicker(
        controller: controller,
        firstDate: DateTime(1990, 1, 1),
        lastDate: DateTime(2025, 3, 18),
        focusedDate: selectedDate,
        itemExtent: 64.0,
        currentDate: DateTime.now(),
        timelineOptions: TimelineOptions(
          height: 150,
          padding: const EdgeInsets.all(8.0),
        ),
        headerOptions: HeaderOptions(
          headerType: HeaderType.picker,
          headerBuilder: (context, date, onTap) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Date of Birth",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: onTap,
                    child: Text(
                      DateFormat('MMMM, yyyy').format(date),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
        //   return InkResponse(
        //     onTap: onTap,
        //     child: CircleAvatar(
        //       backgroundColor: isSelected ? Colors.blue : null,
        //       child: Text(date.day.toString()),
        //     ),
        //   );
        // },
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
          });
        },
      ),
    );
  }

  String? validateUserDetails({
    required String name,
    required String email,
    required String gender,
    required DateTime dob,
    required String phoneNumber,
  }) {
    if (phoneNumber.trim().isEmpty) {
      return "Please enter phone number";
    }
    if (name.trim().isEmpty) {
      return "Please enter your name";
    }
    if (name.trim().isEmpty) {
      return "Please enter your email address";
    }
    if (gender.trim().isEmpty) {
      return "Please select gender";
    }
    if (dob.toString().isEmpty) {
      debugPrint("Selected DOB: $dob");
      if (!isAtLeast18(dob)) {
        return "User must be at least 18 years old";
      }
      return "Date of Birth is required";
    }
    return null; // No validation error
  }

  bool isAtLeast18(DateTime dob) {
    final today = DateTime.now();
    final age = today.year - dob.year;

    return (age > 18) ||
        (age == 18 && dob.month <= today.month && dob.day <= today.day);
  }

  Widget profilePickWidget({
    required String title,
    required String subTitle,
    required items,
    required selectedIndex,
  }) {
    return Column(
      children: [
        SizedBox.fromSize(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(
          subTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => cameraDialog(),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              // Profile Circle
              buildProfileImage(),
              // Add (+) Button
              buildAddButton(),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildProfileImage() {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.redAccent, width: 2),
      ),
      child: BlocConsumer<ImageCubit, ImageState>(
        listener: (context, state) {
          if (state is ImageError) {
            AppSnackBar.showError(context, 'Image selection error');
          } else if (state is ImageSelected) {
            context.read<SignupCubit>().postFileUpload([state.imageFile]);
          }
        },
        builder: (context, state) {
          if (state is ImageLoading) {
            return const Center(
              child: Icon(Icons.person_outline, color: Colors.red, size: 80),
            );
          } else if (state is ImageSelected) {
            return BlocBuilder<SignupCubit, SignupState>(
              builder: (context, stateFile) {
                if (stateFile is FileUploadingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.redAccent),
                  );
                }
                if (stateFile is FileUploadSuccess) {
                  return ClipOval(
                    child: SizedBox(
                      width: 150.0,
                      // Set equal width and height for a perfect circle
                      height: 150.0,
                      child: Image.network(stateFile.data, fit: BoxFit.cover),
                    ),
                  );
                }
                return ClipOval(
                  child: SizedBox(
                    width: 150.0,
                    // Set equal width and height for a perfect circle
                    height: 150.0,
                    child: Image.file(
                      state.imageFile,
                      fit: BoxFit
                          .cover, // Ensures the image covers the entire circular area
                    ),
                  ),
                );
              },
            );
          } else if (state is ImageError) {
            return const Center(
              child: Icon(
                Icons.person_outline,
                color: Colors.redAccent,
                size: 80,
              ),
            );
          } else {
            return  Center(
              child: widget.userPicture!.isNotEmpty
                  ? ClipOval(child: SizedBox(width: 150.0, height: 150.0,
                      child: Image.network(widget.userPicture!, fit: BoxFit.cover),),)
                  : Icon(Icons.person_outline, color: Colors.redAccent, size: 80),
            );
          }
        },
      ),
    );
  }

  Widget buildAddButton() {
    return Positioned(
      bottom: 8,
      right: 8,
      child: Container(
        height: 32,
        width: 32,
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }

  Future<bool> cameraDialog() async {
    final cubit = context.read<ImageCubit>();
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Text('Media file'),
        content: const Text(
          'Take camera / gallery to upload your profile picture ?',
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text("CAMERA", style: TextStyle()),
            onPressed: () {
              cubit.pickImage(context: context, source: ImageSource.camera);
              //Provider.of<ComplaintViewModel>(context, listen: false,).onImageCapture(ImageSource.camera, context: context);
              Navigator.pop(context, false);
            },
          ),

          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text("GALLERY", style: TextStyle()),
            onPressed: () {
              cubit.pickImage(context: context, source: ImageSource.gallery);
              //Provider.of<ComplaintViewModel>(context, listen: false,).onMultiImageCapture(ImageSource.gallery, context: context);
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }
}
