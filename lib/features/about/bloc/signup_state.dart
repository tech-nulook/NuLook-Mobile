part of 'signup_cubit.dart';

@immutable
sealed class SignupState extends Equatable{
 const SignupState();
}

final class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

final class SignupLoading extends SignupState {
  @override
  List<Object> get props => [];
}

final class SignupSuccess extends SignupState {
  final SignupModel signup;
  const SignupSuccess(this.signup);
  @override
  List<Object> get props => [signup];
}

final class SignupFailure extends SignupState {
  final String errorMessage;
  const SignupFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class AboutQuestionSuccess extends SignupState {
  final List<Question> aboutQuestion;
  const AboutQuestionSuccess(this.aboutQuestion);

  @override
  List<Object?> get props => [...aboutQuestion];
}

final class AboutQuestionFailure extends SignupState {
  final String errorMessage;
  const AboutQuestionFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class FileUploadingLoading extends SignupState {
  @override
  List<Object> get props => [];
}

final class FileUploadSuccess extends SignupState {
  final String data;
  const FileUploadSuccess(this.data);

  FileUploadSuccess copyWith({String? data}) {
    return FileUploadSuccess(
      data ?? this.data,
    );
  }

  @override
  List<Object> get props => [data];
}
final class FileUploadFailure extends SignupState {
  final String errorMessage;
  const FileUploadFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class SharedPreferencesHelperData extends SignupState {
  final SignupModel signup;
  const SharedPreferencesHelperData(this.signup);
  @override
  List<Object> get props => [signup];
}
class UserProfileLoading extends SignupState {
  @override
  List<Object> get props => [];
}

class UserProfileLoaded extends SignupState {
  final SignupModel user;
  const UserProfileLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class UserProfileEmpty extends SignupState {
  @override
  List<Object> get props => [];
}

class UserProfileError extends SignupState {
  final String message;
  const UserProfileError(this.message);
  @override
  List<Object> get props => [message];
}

class CustomerLoading extends SignupState {
  @override
  List<Object?> get props => [];
}

class CustomerLoaded extends SignupState {
  final CustomerDetails customerDetails;

  CustomerLoaded(this.customerDetails);
  @override
  List<Object> get props => [customerDetails];
}

class CustomerError extends SignupState {
  final String message;

  CustomerError(this.message);
  @override
  List<Object> get props => [message];
}


class AnswerLoading extends SignupState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AnswerSuccess extends SignupState {
  final dynamic response; // you can replace with your model
  const AnswerSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AnswerFailure extends SignupState {
  final String message;
  const AnswerFailure(this.message);

  @override
  List<Object?> get props => [message];
}