import 'package:equatable/equatable.dart';
import 'package:fastswap/usersLib/users_repository.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

abstract class QrCodeGenState extends Equatable {
  const QrCodeGenState(this.dynamicLink, this.shortLink);

  final String dynamicLink;
  final String shortLink;

  @override
  List<Object> get props => [shortLink, dynamicLink];

  @override
  String toString() =>
      'QrCodeGenState { dynamicLink: $dynamicLink, shortLink: $shortLink}';
}

class NoQRString extends QrCodeGenState {
  const NoQRString() : super('', '');
}

class HasQrString extends QrCodeGenState {
  const HasQrString(String dynamicLink, String shortLink)
      : super(dynamicLink, shortLink);

  @override
  String toString() =>
      'HasQrCodeGenStrings { dynamicLink: $dynamicLink, shortLink: $shortLink}';
}
