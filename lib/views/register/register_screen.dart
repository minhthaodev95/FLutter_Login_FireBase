/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 07:34:00 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:56:24
 */

import 'package:bloc_firebase_login/bloc/register_bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_form.dart';

class RegisterScreen extends StatefulWidget {
  final UserRepository _userRepository;
  RegisterScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterBloc _registerBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(userRepository: _userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => _registerBloc,
        child: RegisterForm(userRepository: _userRepository),
      ),
    );
  }

  @override
  void dispose() {
    _registerBloc.close();
    super.dispose();
  }
}
