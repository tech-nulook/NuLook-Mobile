import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Features/about/bloc/signup_cubit.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImagePicker _picker = ImagePicker();
  ImageCubit() : super(ImageInitial());

  /// Pick image from camera or gallery
  Future<void> pickImage({required BuildContext context, required ImageSource source}) async {
    try {
      emit(ImageLoading());
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) {
        emit(ImageInitial()); // user cancelled
        return;
      }
      // Crop image
      final croppedFile = await _cropImage(pickedFile.path);
      if (croppedFile != null) {
        emit(ImageSelected(File(croppedFile.path)));
      } else {
        emit(ImageInitial());
      }
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }

  /// Crop image using image_cropper
  Future<CroppedFile?> _cropImage(String path) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.redAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );
  }

  void clearImage() => emit(ImageInitial());


}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
