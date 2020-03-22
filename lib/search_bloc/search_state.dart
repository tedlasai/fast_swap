import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/users_repository.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.hasQuery, this.query);

  final bool hasQuery;
  final String query;

  @override
  List<Object> get props => [hasQuery, query];

  @override
  String toString() => 'SearchState { hasQuery: $hasQuery, query:$query }';
}

class Uninitialized extends SearchState {
  const Uninitialized() : super(false, '');
}

class HasSearchStringAndResults extends SearchState {
  final List<User> usersMatched;

  //final int numUsersMatched;

  const HasSearchStringAndResults(this.usersMatched) : super(true, '');

  const HasSearchStringAndResults.queryAndResults(query, this.usersMatched)
      : super(true, query);

  @override
  String toString() => 'HasSearchStrings { hasQuery: $hasQuery, query:$query }';
}

class NoSearchStringAndNoResults extends SearchState {
  const NoSearchStringAndNoResults() : super(false, '');

  const NoSearchStringAndNoResults.query(query) : super(false, query);
}
