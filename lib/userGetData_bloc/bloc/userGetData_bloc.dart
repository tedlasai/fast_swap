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
      return (event is! UserGetDataChanged);
    });
    final debounceStream = events.where((event) {
      return (event is UserGetDataChanged);
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
    } else if (event is UserGetDataChanged) {
      yield* _mapUserGetDataChanged(event);
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

  Stream<UserGetDataState> _mapUserGetDataChanged(
      UserGetDataChanged event) async* {
    //need to update with validators
    yield state.update(
        isUsernameValid: await validateUsername(event.username),
        isEmailValid: Validators.isValidEmail(event.email),
        isPhoneNumberValid: Validators.isValidPhoneNumber(event.phoneNumber),
        isSnapchatValid: Validators.isValidHandle(event.snapchat),
        isFacebookValid: Validators.isValidHandle(event.facebook),
        isInstagramValid: Validators.isValidHandle(event.instagram),
        isTwitterValid: Validators.isValidHandle(event.twitter),
        );
  }

  Future<String> validateUsername(String username) async {
    String firstValidation = Validators.isValidUsername(username);
    if(firstValidation == "VALID" && !state.hasUserData) {
      try {
        QuerySnapshot usersMatchedSnapshot =
            await _usersRepository.findUsername(username.toLowerCase());

        List<User> usersMatched = usersMatchedSnapshot.documents
            .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
            .toList();

        if(usersMatched.length == 0) {
          return "VALID";
        } else {
          return "Username already exists";
        }
      } catch (_) {
        print("Unique username checking failed horribly");
      }
    } else {
      return firstValidation;
    }
  }

  Stream<UserGetDataState> _mapUserGetDataSubmitted(
      UserGetDataSubmitted event) async* {
    try {
      User user = User(
          uid: event.uid,
          username: event.username,
          twitter: event.twitter,
          facebook: event.facebook,
          snapchat: event.snapchat,
          phoneNumber: Validators.getNumbersFromPhoneNumber(event.phoneNumber),
          instagram: event.instagram,
          email: event.email,
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
