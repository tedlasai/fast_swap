import 'package:barcode_scan/barcode_scan.dart';
import 'package:fastswap/displayUserData_bloc/displayUserData.dart';
import 'package:fastswap/widgets/showAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class ScanQRCode extends StatefulWidget {
  @override
  ScanQRCode({Key key}) : super(key: key);

  State<StatefulWidget> createState() => ScanQRCodeState();
}

class ScanQRCodeState extends State<ScanQRCode> {
  String barcode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        scan(context);
      },
      child: Icon(Icons.photo_camera),
      backgroundColor: Colors.blue,
    );
  }

  Future scan(BuildContext context) async {
    try {
      String barcode = await BarcodeScanner.scan();
      if (barcode != null && barcode != "") {
        print("barcode" + barcode);
        BlocProvider.of<DisplayUserDataBloc>(context)
            .add(DisplayUserDataUpdatedByLink(link: barcode, shortLink: true));
      } else {
        showAlertDialog(context, "Invalid QR Code", "Try Another QR Code");
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showAlertDialog(context, "No Camera Permissions!",
            "Please enable camera to scan your friends' QR codes.");
      }
    } on FormatException {} catch (e) {}
  }
}
