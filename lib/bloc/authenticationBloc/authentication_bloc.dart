/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 03:41:32 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:50:57
 */

import 'dart:async';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc({required this.userRepository}) : super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

//_mapAppStartedToState
  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignIn = await userRepository.isSignIn();
      if (isSignIn) {
        final email = await userRepository.getUser();
        yield Authenticated(displayName: email);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }
//_mapLoggedInToState

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(displayName: await userRepository.getUser());
  }

// /_mapLoggedOutToState

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    userRepository.signOut();
  }
}
