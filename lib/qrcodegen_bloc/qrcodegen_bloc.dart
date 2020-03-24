import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastswap/qrcodegen_bloc/qrcodegen.dart';
import 'package:fastswap/usersLib/src/entities/entities.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastswap/usersLib/users_repository.dart';

class QrCodeGenBloc extends Bloc<QrCodeGenEvent, QrCodeGenState> {
  @override
  QrCodeGenState get initialState => NoQRString();

  @override
  Stream<QrCodeGenState> mapEventToState(
    QrCodeGenEvent event,
  ) async* {
    if (event is QrCodeGenClear) {
      yield* _mapQrCodeGenClearToState();
    } else if (event is QrCodeGenUpdate) {
      yield* _mapQrCodeGenUpdateToState(event);
    }
  }

  Stream<QrCodeGenState> _mapQrCodeGenClearToState() async* {
    yield NoQRString();
  }

  Stream<QrCodeGenState> _mapQrCodeGenUpdateToState(
      QrCodeGenUpdate event) async* {
    yield HasQrString(event.qrString);
  }
}
