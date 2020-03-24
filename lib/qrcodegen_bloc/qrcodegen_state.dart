import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/users_repository.dart';

abstract class QrCodeGenState extends Equatable {
  const QrCodeGenState(this.qrString);

  final String qrString;

  @override
  List<Object> get props => [qrString];

  @override
  String toString() => 'QrCodeGenState { qrString: $qrString,}';
}

class NoQRString extends QrCodeGenState {
  const NoQRString() : super('');
}

class HasQrString extends QrCodeGenState {
  const HasQrString(String qrString) : super(qrString);

  @override
  String toString() => 'HasQrCodeGenStrings { qrString: $qrString}';
}
