import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.username,
  });

  @override
  List<Object?> get props => [email, password, username];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}

class UpdateProfileRequested extends AuthEvent {
  final String username;
  final String avatar;

  const UpdateProfileRequested({required this.username, required this.avatar});

  @override
  List<Object?> get props => [username, avatar];
}

class DeleteAccountRequested extends AuthEvent {}
