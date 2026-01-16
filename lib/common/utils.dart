import 'package:flutter/material.dart';
import 'package:nulook_app/common/widgets/customModalBottomSheet.dart';

import '../Core/Theme/colors.dart';

class Utils {
  /// Opens a modal bottom sheet with customizable options.
  static Future<dynamic> openModalBottomSheet(
    BuildContext buildContext,
    Widget children, {
    bool? isScrollControlled = true,
    bool? staticContent = false}) async {

    return await showModalBottomSheet(
      enableDrag: true,
      // Keep this true for draggable behavior
      showDragHandle: false,
      // Set to true to show the drag handle
      isScrollControlled: true,
      // Use the passed value
      barrierColor: AppColors.blackColor.withValues(alpha: 0.6),
      // Better way to set opacity
      backgroundColor: transparentColor,
      // Keeps the main sheet transparent
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      context: buildContext,
      builder: (_) => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: CustomModalButtonSheet(
          staticContent: staticContent,
          child: children,
        ),
      ),
    );
  }
  


}
