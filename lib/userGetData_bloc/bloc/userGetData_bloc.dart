import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/usersLib/src/entities/user_entity.dart';
import 'package:fastswap/users_bloc/users_event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fastswap/userGetData_bloc/bloc/bloc.dart';
import 'package:fastswap/usersLib/users_repository.dart';
import 'package:fastswap/validators.dart';

class UserGetDataBloc extends Bloc<UserGetDataEvent, UserGetDataState> {
  UsersRepository _usersRepository;

  UserGetDataBloc({@required UsersRepository usersRepository})
      : assert(usersRepository != null),
        _usersRepository = usersRepository;

  @override
  UserGetDataState get initialState => UserGetDataState.empty();

  @override
  Stream<UserGetDataState> transformEvents(
    Stream<UserGetDataEvent> events,
    Stream<UserGetDataState> Function(UserGetDataEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! UserGetDataUsernameChanged);
    });
    final debounceStream = events.where((event) {
      return (event is UserGetDataUsernameChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<UserGetDataState> mapEventToState(UserGetDataEvent event) async* {
    if (event is UserGetDataStart) {
      yield* _mapUserGetDataStart(event);
    } else if (event is UserGetDataSubmitted) {
      yield* _mapUserGetDataSubmitted(event);
    } else if (event is UserGetDataUsernameChanged) {
      yield* _mapUserGetDataUsernameChanged(event.username);
    } else if (event is UserGetDataUninitialized) {
      yield* _mapUserGetDataUninitialized();
    }
  }

  Stream<UserGetDataState> _mapUserGetDataStart(UserGetDataStart event) async* {
    try {
      User user = User(uid: event.uid);
      DocumentReference documentReference =
          await _usersRepository.pullUser(user);
      DocumentSnapshot documentSnapshot = await documentReference.get();
      if (documentSnapshot.exists) {
        UserEntity userEntity = UserEntity.fromSnapshot(documentSnapshot);
        Map<String, Object> data = userEntity.toDocument();
        if (data["username"] != null && data["username"] != "") {
          yield UserGetDataState.success();
        } else {
          yield UserGetDataState.loadedUser();
        }
      } else {
        yield UserGetDataState.loadedUser();
      }
      //print(data);
      //add(UserGetDataHasUserData(data));

    } catch (_) {
      yield UserGetDataState.failure();
    }
  }

  Stream<UserGetDataState> _mapUserGetDataUsernameChanged(
      String username) async* {
    yield state.update(
      isUsernameValid: Validators.isValidUsername(username),
    );
  }

  Stream<UserGetDataState> _mapUserGetDataSubmitted(
      UserGetDataSubmitted event) async* {
    try {
      User user = User(
          uid: event.uid,
          username: event.username,
          displayName: event.displayName);
      _usersRepository.setNewUser(user);
      yield UserGetDataState.success();
    } catch (_) {
      yield UserGetDataState.failure();
    }
  }

  Stream<UserGetDataState> _mapUserGetDataUninitialized() async* {
    try {
      yield UserGetDataState.empty();
    } catch (_) {
      yield UserGetDataState.failure();
    }
  }
}
