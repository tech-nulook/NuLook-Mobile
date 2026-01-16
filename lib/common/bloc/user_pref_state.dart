part of 'user_pref_cubit.dart';



class UserPrefState extends Equatable {
  final String userName;
  final String userEmail;
  final String userPicture;
  final String phoneNumber;
  final String gender;
  final String location;
  final bool isLoaded;

  const UserPrefState({
    this.userName = '',
    this.userEmail = '',
    this.userPicture = '',
    this.phoneNumber = '',
    this.gender = '',
    this.location = '',
    this.isLoaded = false,
  });

  UserPrefState copyWith({
    String? userName,
    String? userEmail,
    String? userPicture,
    String? phoneNumber,
    String? gender,
    String? location,
    bool? isLoaded,
  }) {
    return UserPrefState(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPicture: userPicture ?? this.userPicture,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }

  @override
  List<Object?> get props => [
    userName,
    userEmail,
    userPicture,
    phoneNumber,
    gender,
    location,
    isLoaded,
  ];
}