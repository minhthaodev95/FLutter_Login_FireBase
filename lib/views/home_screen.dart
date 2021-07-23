/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 06:26:49 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:56:05
 */
import 'package:bloc_firebase_login/repository/user_repository.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_firebase_login/bloc/authenticationBloc/authentication_bloc.dart';
import 'package:bloc_firebase_login/bloc/authenticationBloc/authentication_event.dart';

import 'login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final name;
  const HomeScreen({Key? key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeScreen'),
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Text('Welcome $name'),
            )
          ],
        ));
  }
}
