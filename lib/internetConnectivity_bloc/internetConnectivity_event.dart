import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class InternetConnectivityEvent extends Equatable {
  @override
  const InternetConnectivityEvent();

  List<Object> get props => [];
}

class InternetConnectivityStarted extends InternetConnectivityEvent {}

class InternetConnectivityChanged extends InternetConnectivityEvent {
  final bool connectionGood;

  const InternetConnectivityChanged({@required this.connectionGood});

  @override
  List<Object> get props => [connectionGood];

  @override
  String toString() =>
      'InternetConnectivityChanged { connectionGood :$connectionGood }';
}
