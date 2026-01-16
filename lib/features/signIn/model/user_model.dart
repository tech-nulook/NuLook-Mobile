
class UserModel {
  final String message;

  UserModel({
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json['message'] ?? '',
  );
}