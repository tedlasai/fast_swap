import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class QrCodeGenEvent extends Equatable {
  @override
  const QrCodeGenEvent();

  List<Object> get props => [];
}

class QrCodeGenUpdate extends QrCodeGenEvent {
  final String qrString;

  const QrCodeGenUpdate({@required this.qrString});

  @override
  List<Object> get props => [qrString];

  @override
  String toString() => 'QrCodeGenUpdated { query :$qrString }';
}

class QrCodeGenClear extends QrCodeGenEvent {}
