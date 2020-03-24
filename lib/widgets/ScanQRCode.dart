import 'package:barcode_scan/barcode_scan.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:fastswap/displayUserData_bloc/displayUserData.dart';
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
      print("BARCODE $barcode");
      if (barcode != null && barcode != "") {
        BlocProvider.of<DisplayUserDataBloc>(context)
            .add(DisplayUserDataUpdatedByLink(link: barcode));
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

  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
