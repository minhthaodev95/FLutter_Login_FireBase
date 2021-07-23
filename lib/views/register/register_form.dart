/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 07:35:50 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:56:17
 */

import 'package:bloc_firebase_login/bloc/authenticationBloc/authentication_bloc.dart';
import 'package:bloc_firebase_login/bloc/register_bloc/register_bloc.dart';
import 'package:bloc_firebase_login/bloc/register_bloc/register_state.dart';
import 'package:bloc_firebase_login/bloc/register_bloc/register_event.dart';
import 'package:bloc_firebase_login/views/login/login_screen.dart';
import 'package:bloc_firebase_login/views/register/signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_firebase_login/bloc/authenticationBloc/authentication_event.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';

// ignore: must_be_immutable
class RegisterForm extends StatefulWidget {
  UserRepository _userRepository;

  RegisterForm({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late RegisterBloc _registerBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        print(state);
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('SignUp Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Signing Up...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          ScaffoldMessenger.of(context)
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sign Up Successed !...'),
                  ],
                ),
                backgroundColor: Colors.green,
              ),
            );
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreen(userRepository: _userRepository)),
          );
        }
      },
      child: BlocBuilder(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'Register Screen',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      autocorrect: false,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          SignUpButton(onPressed: _onFormSubmitted),
                          SizedBox(height: 5),
                          SizedBox(height: 5),
                          BackToLoginButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    // _loginBloc.emit(EmailChanged(email: email));
    _registerBloc.add(EmailChanged(email: _emailController.text.trim()));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      SignUpWithCredentialsPressed(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }
}

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        child: Text(' Back To Login'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ));
  }
}
