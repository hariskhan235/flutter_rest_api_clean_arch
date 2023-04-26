import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String message;
  const LoginFailure({required this.message});
}

class SignupInitial extends AuthState {}

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailure extends AuthState {}
