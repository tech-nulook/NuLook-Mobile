part of 'sign_in_cubit.dart';

sealed class SignInState extends Equatable {
  const SignInState();
}

final class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends SignInState {
  @override
  List<Object> get props => [];
}

final class SignInSuccess extends SignInState {
  final String messages;
  const SignInSuccess(this.messages);


  SignInSuccess copyWith({String? messages}) {
    return SignInSuccess(messages ?? this.messages);
  }

  @override
  List<Object> get props => [messages];
}

final class SignInFailure extends SignInState {
  final String message;
  const SignInFailure(this.message);

  SignInFailure copyWith({String? message}){
    return SignInFailure(message ?? this.message);
  }

  @override
  List<Object> get props => [message];
}

final class OtpSuccess extends SignInState {
  final OtpModel otpModel;
  const OtpSuccess(this.otpModel);

  @override
  List<Object> get props => [otpModel];
}

final class OtpFailure extends SignInState {
  final String message;

  const OtpFailure(this.message);

  @override
  List<Object> get props => [message];
}
