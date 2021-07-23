import 'package:bloc_firebase_login/bloc/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bloc_firebase_login/bloc/login_bloc/login_event.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(FontAwesomeIcons.google, color: Colors.white),
        onPressed: () {
          // BlocProvider.of<LoginBloc>(context).emit(
          //   LoginWithGooglePressed();
          // );
          BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
        },
        label:
            Text('Sign in with Google', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
