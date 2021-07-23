/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 08:09:37 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:10:50
 */
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text('Login'),
      ),
    );
  }
}
