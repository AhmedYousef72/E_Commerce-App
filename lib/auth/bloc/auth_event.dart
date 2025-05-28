import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ForgetPasswordEvent extends AuthEvent {
  final String email;

  ForgetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;

  VerifyOtpEvent({required this.otp});

  @override
  List<Object> get props => [otp];
}
