import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nulook_app/common/common_button.dart';

import '../../../common/square_textfield.dart';
import '../../../core/theme/theme_cubit.dart';


class LocationBottomSheetWidget extends StatefulWidget {
  const LocationBottomSheetWidget({super.key});

  @override
  State<LocationBottomSheetWidget> createState() => _LocationBottomSheetWidgetState();
}

class _LocationBottomSheetWidgetState extends State<LocationBottomSheetWidget> {
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return StatefulBuilder(
      builder: (context, setState) {
        return SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Update your Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Select your location to see available products and offers in your area.",
                  style: TextStyle(fontSize: 12,color: Colors.grey.shade500),
                ),
                //Can you create a text field with square border here to enter location with a submit button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SquareTextField(
                    controller: _locationController,
                    hintText: "search for your location",
                    prefixIcon: Icons.location_on,
                    suffixIcon: Icons.close,
                    fillColor: Colors.transparent,
                    focusedBorderColor: isDark ? Colors.white : Colors.black,
                    textColor: isDark ? Colors.white : Colors.black,
                    hintColor: isDark ? Colors.white30 : Colors.black54,
                    iconColor: isDark ? Colors.white30 : Colors.black54,
                    keyboardType: TextInputType.text,
                    validator: null,
                  ),
                ),
                SizedBox(height: 10),
                CommonButton(
                  title: 'Update Location',
                  onPressed: () {
                    // Handle submit action
                    Navigator.of(context).pop();
                  },
                ),

                SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}
