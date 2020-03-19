import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/usersLib/src/entities/entities.dart';
import 'package:fastswap/users_bloc/users.dart';
import 'package:fastswap/usersLib/users_repository.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _usersRepository;

  UsersBloc({@required UsersRepository usersRepository})
      : assert(usersRepository != null),
        _usersRepository = usersRepository;

  @override
  UsersState get initialState => UsersLoading();

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is LoadUser) {
      yield* _mapLoadUserToState(event);
    } else if (event is AddUser) {
      yield* _mapAddUserToState(event);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(event);
    } else if (event is DeleteUser) {
      yield* _mapDeleteUserToState(event);
    } else if (event is UsersInfoUpdated) {
      yield* _mapUserInfoUpdatedToState(event);
    }
  }

  Stream<UsersState> _mapLoadUserToState(LoadUser event) async* {
    User user = User(uid: event.uid);
    DocumentReference documentReference = await _usersRepository.pullUser(user);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    UserEntity userEntity = UserEntity.fromSnapshot(documentSnapshot);
    Map<String, Object> data = userEntity.toDocument();
    add(UsersInfoUpdated(data));
  }

  Stream<UsersState> _mapAddUserToState(AddUser event) async* {
    _usersRepository.addNewUser(event.user);
  }

  Stream<UsersState> _mapUpdateUserToState(UpdateUser event) async* {
    _usersRepository.updateUser(event.updatedUser);
  }

  Stream<UsersState> _mapDeleteUserToState(DeleteUser event) async* {
    _usersRepository.deleteUser(event.user);
  }

  Stream<UsersState> _mapUserInfoUpdatedToState(UsersInfoUpdated event) async* {
    yield UserInfoLoaded(event.userInfo);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
