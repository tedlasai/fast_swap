import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SearchEvent extends Equatable {
  @override
  const SearchEvent();

  List<Object> get props => [];
}

class SearchStarted extends SearchEvent {}

class SearchUpdated extends SearchEvent {
  final String query;

  const SearchUpdated({@required this.query});

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'SearchUpdated { query :$query }';
}

class SearchClear extends SearchEvent {}
