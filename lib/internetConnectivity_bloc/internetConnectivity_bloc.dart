import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:fastswap/internetConnectivity_bloc/internetConnectivity.dart';
import 'package:fastswap/usersLib/src/entities/entities.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastswap/usersLib/users_repository.dart';

class InternetConnectivityBloc
    extends Bloc<InternetConnectivityEvent, InternetConnectivityState> {
  StreamSubscription _internetConnectivitySubscription;
  Connectivity _internetConnectivity;

  InternetConnectivityBloc({@required Connectivity internetConnectivity})
      : assert(internetConnectivity != null),
        _internetConnectivity = internetConnectivity {
    _internetConnectivitySubscription = _internetConnectivity
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      add(InternetConnectivityChanged(
          connectionGood: result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi));
    });
  }

  @override
  InternetConnectivityState get initialState {
    return InternetUninitialized();
  }

  @override
  Stream<InternetConnectivityState> mapEventToState(
    InternetConnectivityEvent event,
  ) async* {
    if (event is InternetConnectivityStarted) {
      yield* _mapInternetConnectivityStartedToState();
    } else if (event is InternetConnectivityChanged) {
      yield* _mapInternetConnectivityChangedToState(event);
    }
  }

  Stream<InternetConnectivityState>
      _mapInternetConnectivityStartedToState() async* {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        add(InternetConnectivityChanged(
            connectionGood: connectivityResult == ConnectivityResult.mobile ||
                connectivityResult == ConnectivityResult.wifi));
      }
    } catch (_) {
      yield InternetUninitialized();
    }
  }

  Stream<InternetConnectivityState> _mapInternetConnectivityChangedToState(
      InternetConnectivityChanged event) async* {
    if (event.connectionGood) {
      yield HasConnection();
    } else {
      yield NoConnection();
    }
  }
}
