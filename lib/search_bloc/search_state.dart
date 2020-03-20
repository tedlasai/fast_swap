import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.hasQuery, this.query);

  final bool hasQuery;
  final String query;

  @override
  List<Object> get props => [hasQuery, query];

  @override
  String toString() =>
      'SearchState { hasQuery: $hasQuery, displayName:$query }';
}

class Uninitialized extends SearchState {
  const Uninitialized() : super(false, '');
}

class HasSearchString extends SearchState {
  const HasSearchString() : super(false, '');

  const HasSearchString.query(query) : super(true, query);
}

class NoSearchString extends SearchState {
  const NoSearchString() : super(false, '');
}
