/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 06:44:20 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:51:46
 */

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email}) : super([email]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({required this.password}) : super([password]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginWithGooglePressed extends LoginEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({required this.email, required this.password})
      : super([email, password]);

  @override
  List<Object?> get props => throw UnimplementedError();
}
