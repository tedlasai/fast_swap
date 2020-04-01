import 'package:fastswap/qrcodegen_bloc/qrcodegen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

import 'customLinkWidget.dart';

class GenerateQRCode extends StatefulWidget {
  State<StatefulWidget> createState() => GenerateQRCodeState();
}

class GenerateQRCodeState extends State<GenerateQRCode> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String shortLink;
  String dynamicLink;
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    shortLink = "";
    dynamicLink = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrCodeGenBloc, QrCodeGenState>(
        builder: (context, state) {
      if (state is HasQrString) {
        shortLink = state.shortLink;
        dynamicLink = state.dynamicLink;
      }
      final bodyHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewInsets.bottom;

      return SingleChildScrollView(
          child: Container(
        color: const Color(0xFFFFFFFF),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
            ),
            Text("Your Personal QR Code! Share it with others!"),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.photo,
                      size: 40,
                    ),
                    onPressed: () => _captureAndSharePng(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  IconButton(
                    icon: Icon(Icons.link, size: 40),
                    onPressed: () => _captureAndShareLink(),
                  )
                ])),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: dynamicLink,
                  size: 0.4 * bodyHeight,
                ),
              ),
            ),
          ],
        ),
      ));
    });
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      Directory tempDir;
      if (Platform.isIOS) {
        tempDir = await getApplicationDocumentsDirectory();
      } else {
        //android
        tempDir = await getExternalStorageDirectory();
      }
      final file = await new File('${tempDir.path}/YourFastSwapQR.png');
      await file.writeAsBytes(pngBytes);

      //FlutterShareFile.shareImage(tempDir.path, 'image.png');

      await FlutterShare.shareFile(
        title: 'YourFastSwapQR',
        filePath: '${tempDir.path}/YourFastSwapQR.png',
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _captureAndShareLink() async {
    try {
      //FlutterShareFile.shareImage(tempDir.path, 'image.png');
      //await Share.text("Your Link", shortLink, 'text/plain');
      await FlutterShare.share(title: 'Your FastSwap Link', linkUrl: shortLink);
    } catch (e) {
      print(e.toString());
    }
  }
}
