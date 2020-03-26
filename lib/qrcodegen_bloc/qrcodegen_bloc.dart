import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastswap/qrcodegen_bloc/qrcodegen.dart';
import 'package:fastswap/usersLib/src/entities/entities.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
    Uri dynamicLink = await generateLink(event.qrString);
    String shortLink = await getShortenLink(dynamicLink);
    yield HasQrString(dynamicLink.toString(), shortLink);
  }

  Future<Uri> generateLink(String usernameLowercase) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://fastswap.page.link',
        socialMetaTagParameters: SocialMetaTagParameters(
            description: "Connect with $usernameLowercase!",
            title: "FastSwap",
            imageUrl: Uri.parse(
                "https://fastswap-57631.firebaseapp.com/img/fastswap_logo.jpg")),
        link: Uri.parse(
            "https://fastswap-57631.firebaseapp.com?username=$usernameLowercase"),
        androidParameters: AndroidParameters(
          packageName: 'com.saico.fastswap',
          minimumVersion: 1,
        ),
        iosParameters: IosParameters(
          bundleId: 'com.saico.fastswap',
          minimumVersion: '1.0.0',
          appStoreId: '1504397621',
        ));

    final Uri dynamicUrl = await parameters.buildUrl();
    return dynamicUrl;
  }

  Future<String> getShortenLink(Uri dynamicUrl) async {
    final ShortDynamicLink shortenedLink =
        await DynamicLinkParameters.shortenUrl(
            dynamicUrl,
            DynamicLinkParametersOptions(
                shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short));

    print(shortenedLink.shortUrl.toString());
    return shortenedLink.shortUrl.toString();
  }
}
