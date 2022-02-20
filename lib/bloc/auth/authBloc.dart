import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import './authRepository.dart';

abstract class AuthEvents {}

class StartAuthentication extends AuthEvents {
  final String username;
  final String password;
  StartAuthentication({required this.username, required this.password});
}

class StartRegistration extends AuthEvents {
  final Map<String, String> signupData;
  StartRegistration(this.signupData);
}

enum AuthStatus { authenticated, unAuthenticated, unknown }

abstract class AuthState {
  final AuthStatus? status = AuthStatus.unAuthenticated;
}

class AuthInitialState extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> userData;
  @override
  final AuthStatus? status;
  AuthSuccess(this.status, this.userData);
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthEvents>((event, emit) async {
      debugPrint('event $event');
      if (event is StartAuthentication) {
        final result = await authenticateUser(
            username: event.username, password: event.password);
        result.fold((l) => emit(AuthError(l.toString())),
            (r) => emit(AuthSuccess(AuthStatus.authenticated, r)));
      } else if (event is StartRegistration) {
        // code for registration API call
      }
    });
  }
}
