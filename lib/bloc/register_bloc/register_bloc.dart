/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 06:35:14 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:51:40
 */

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_login/bloc/register_bloc/register_event.dart';
import 'package:bloc_firebase_login/bloc/register_bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';
import 'package:bloc_firebase_login/validators/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;

  RegisterBloc({required this.userRepository}) : super(RegisterState.empty());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is SignUpWithCredentialsPressed) {
      yield* _mapSignUpWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapLoginWithGooglePressedToState() async* {
    try {
      await userRepository.signInWithGoogle();
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }

  Stream<RegisterState> _mapSignUpWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield RegisterState.loading();
    try {
      await userRepository.signUp(email, password);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
