import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/users_repository.dart';

abstract class InternetConnectivityState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'InternetConnectivityState { }';
}

class InternetUninitialized extends InternetConnectivityState {}

class HasConnection extends InternetConnectivityState {}

class NoConnection extends InternetConnectivityState {}
