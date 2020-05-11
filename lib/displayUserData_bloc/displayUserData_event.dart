import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/src/models/user.dart';
import 'package:flutter/cupertino.dart';

abstract class DisplayUserDataEvent extends Equatable {
  @override
  const DisplayUserDataEvent();

  List<Object> get props => [];
}

class DisplayUserDataStarted extends DisplayUserDataEvent {}

class DisplayUserDataUpdated extends DisplayUserDataEvent {
  final User data;

  const DisplayUserDataUpdated({@required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'DisplayUserDataUpdated { query :$data }';
}

class DisplayUserDataUpdatedByLink extends DisplayUserDataEvent {
  final String link;
  final bool shortLink;

  const DisplayUserDataUpdatedByLink(
      {@required this.link, @required this.shortLink});

  @override
  List<Object> get props => [link, shortLink];

  @override
  String toString() =>
      'DisplayUserDataUpdatedByLink { link :$link, shortLink: $shortLink}';
}

class DisplayUserDataClear extends DisplayUserDataEvent {}
