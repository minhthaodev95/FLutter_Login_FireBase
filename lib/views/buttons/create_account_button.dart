/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 06:44:20 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:49:56
 */
import 'package:flutter/material.dart';
import 'package:bloc_firebase_login/views/register/register_screen.dart';
import 'package:bloc_firebase_login/repository/user_repository.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key? key, @required userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        child: Text(
          'Create an Account',
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return RegisterScreen(userRepository: _userRepository);
            }),
          );
        },
      ),
    );
  }
}
