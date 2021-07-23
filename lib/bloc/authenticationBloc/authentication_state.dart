/*
 * @Author: Minh Thao Nguyen 
 * @Date: 2021-07-21 03:25:37 
 * @Last Modified by: Minh Thao Nguyen
 * @Last Modified time: 2021-07-21 08:51:09
 */

import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]);
}

//
class Uninitialized extends AuthenticationState {
  @override
  String toString() {
    return 'Uninitialized';
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Authenticated extends AuthenticationState {
  final String? displayName;

  Authenticated({required this.displayName}) : super([displayName]);
  @override
  String toString() {
    return 'Authenticated';
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'Unauthenticated';
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
