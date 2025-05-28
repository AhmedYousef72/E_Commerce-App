import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ForgetPasswordEvent>(_onForgetPassword);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    if (event.email == "test@example.com" && event.password == "password") {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(error: "Invalid credentials"));
    }
  }

  void _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    emit(AuthSuccess());
  }

  void _onForgetPassword(
    ForgetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // Simulate sending a verification code to the email
    await Future.delayed(Duration(seconds: 2));
    emit(AuthSuccess());
  }

  /*************  ✨ Codeium Command ⭐  *************/
  /// Handles [VerifyOtpEvent] by simulating an API call to verify the OTP,
  /// and emitting [AuthSuccess] or [AuthFailure] accordingly.
  /******  819ac3c2-1073-429d-b2eb-6badf4fbdb6f  *******/
  void _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    if (event.otp == "123456") {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(error: "Invalid OTP"));
    }
  }
}
