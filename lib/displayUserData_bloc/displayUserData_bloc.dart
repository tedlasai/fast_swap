import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastswap/displayUserData_bloc/displayUserData.dart';
import 'package:fastswap/usersLib/src/entities/entities.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastswap/usersLib/users_repository.dart';

class DisplayUserDataBloc
    extends Bloc<DisplayUserDataEvent, DisplayUserDataState> {
  @override
  DisplayUserDataState get initialState => NoUserData();

  @override
  Stream<DisplayUserDataState> mapEventToState(
    DisplayUserDataEvent event,
  ) async* {
    if (event is DisplayUserDataStarted) {
      yield* _mapDisplayUserDataStartedToState();
    } else if (event is DisplayUserDataUpdated) {
      yield* _mapDisplayUserDataUpdatedToState(event);
    } else if (event is DisplayUserDataClear) {
      yield* _mapDisplayUserDataClearToState();
    }
  }

  Stream<DisplayUserDataState> _mapDisplayUserDataStartedToState() async* {
    yield NoUserData();
  }

  Stream<DisplayUserDataState> _mapDisplayUserDataUpdatedToState(
      DisplayUserDataUpdated event) async* {
    yield HasUserData(event.data);
  }

  Stream<DisplayUserDataState> _mapDisplayUserDataClearToState() async* {
    yield NoUserData();
  }
}
