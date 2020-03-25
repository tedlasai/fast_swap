import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:fastswap/qrcodegen_bloc/qrcodegen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_file/flutter_share_file.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class GenerateQRCode extends StatefulWidget {
  final String _qrString;

  @override
  GenerateQRCode({Key key, @required qrString})
      : assert(qrString != null),
        _qrString = qrString,
        super(key: key);

  State<StatefulWidget> createState() => GenerateQRCodeState();
}

class GenerateQRCodeState extends State<GenerateQRCode> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String qrString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    qrString = widget._qrString;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrCodeGenBloc, QrCodeGenState>(
        builder: (context, state) {
      if (state is HasQrString) {
        qrString = state.qrString;
      }
      final bodyHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewInsets.bottom;
      return SingleChildScrollView(
          child: Container(
        color: const Color(0xFFFFFFFF),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(50),
            ),
            Text("Your Personal QR Code! Share it with others!"),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: qrString,
                  embeddedImage: AssetImage('assets/fastswap_logo.JPG'),
                  size: 0.4 * bodyHeight,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: _captureAndSharePng,
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

      Directory tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png');
      await file.writeAsBytes(pngBytes);

      //FlutterShareFile.shareImage(tempDir.path, 'image.png');
      await Share.file(
          'esys image', 'YourFastSwapQR.png', pngBytes, 'image/png');
    } catch (e) {
      print(e.toString());
    }
  }
}
