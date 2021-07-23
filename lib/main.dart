/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 06:07:29 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:50:38
 * 
 */

import 'package:bloc_firebase_login/bloc/authenticationBloc/authentication_bloc.dart';
import 'package:bloc_firebase_login/views/login/login_screen.dart';
import 'package:bloc_firebase_login/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_firebase_login/bloc/authenticationBloc/authentication_state.dart';
import 'package:bloc_firebase_login/bloc/authenticationBloc/authentication_event.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';
import 'package:bloc_firebase_login/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      home: App(),
      title: 'Login Firebase Bloc',
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

//state
class _AppState extends State<App> {
  final UserRepository _userRepository = UserRepository();
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: Scaffold(
        body: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen(userRepository: _userRepository);
            }
            if (state is Authenticated) {
              return HomeScreen(name: state.displayName);
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }
}
