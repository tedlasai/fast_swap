import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastswap/search_bloc/search.dart';
import 'package:fastswap/usersLib/src/entities/entities.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastswap/usersLib/users_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UsersRepository _usersRepository;

  SearchBloc({@required UsersRepository usersRepository})
      : assert(usersRepository != null),
        _usersRepository = usersRepository;

  @override
  SearchState get initialState => Uninitialized();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchStarted) {
      yield* _mapSearchStartedToState();
    } else if (event is SearchUpdated) {
      yield* _mapSearchUpdatedToState(event);
    } else if (event is SearchClear) {
      yield* _mapSearchClearToState();
    }
  }

  Stream<SearchState> _mapSearchStartedToState() async* {
    yield Uninitialized();
  }

  Stream<SearchState> _mapSearchUpdatedToState(SearchUpdated event) async* {
    QuerySnapshot usersMatchedSnapshot =
        await _usersRepository.findUsers(event.query.toLowerCase());
    List<User> usersMatched = usersMatchedSnapshot.documents
        .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
        .toList();

    if (event.query != "") {
      yield HasSearchStringAndResults.queryAndResults(
          event.query, usersMatched);
    } else {
      String query = event.query;
      print("EVENT.query $query");
      yield NoSearchStringAndNoResults.query(event.query);
    }
  }

  Stream<SearchState> _mapSearchClearToState() async* {
    yield NoSearchStringAndNoResults();
  }
}
