import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/storage/secure_storage_constant.dart';
import '../../core/storage/shared_preferences_helper.dart';

part 'user_pref_state.dart';


class UserPrefCubit extends Cubit<UserPrefState> {
  final SharedPreferencesHelper _prefs;

  UserPrefCubit(this._prefs) : super(const UserPrefState());

  /// Load data once (call at app start)
  Future<void> loadUserData() async {
    await _prefs.init();

    emit(
      state.copyWith(
        userName: _prefs.getString(SecureConstant.userName) ?? '',
        userEmail: _prefs.getString(SecureConstant.userEmail) ?? '',
        userPicture: _prefs.getString(SecureConstant.userPicture) ?? '',
        phoneNumber: _prefs.getString(SecureConstant.phoneNumber) ?? '',
        gender: _prefs.getString(SecureConstant.gender) ?? '',
        location: _prefs.getString(SecureConstant.location) ?? '',
        isLoaded: true,
      ),
    );
  }

  /// Save all user data at once
  Future<void> saveUserData({String? userName,  String? userEmail, String? userPicture, String? phoneNumber, String? gender, String? location }) async {
    if (userName != null) await _prefs.setString(SecureConstant.userName, userName);
    if (userEmail != null) await _prefs.setString(SecureConstant.userEmail, userEmail);
    if (userPicture != null) await _prefs.setString(SecureConstant.userPicture, userPicture);
    if (phoneNumber != null) await _prefs.setString(SecureConstant.phoneNumber, phoneNumber);
    if (gender != null) await _prefs.setString(SecureConstant.gender, gender);
    if (location != null) await _prefs.setString(SecureConstant.location, location);

    emit(
      state.copyWith(
        userName: userName ?? state.userName,
        userEmail: userEmail ?? state.userEmail,
        userPicture: userPicture ?? state.userPicture,
        phoneNumber: phoneNumber ?? state.phoneNumber,
        gender: gender ?? state.gender,
        location: location ?? state.location,
      ),
    );
  }

  /// Clear all user data (logout)
  Future<void> clearUserData() async {
    await _prefs.clear();
    emit(const UserPrefState(isLoaded: true));
  }
}