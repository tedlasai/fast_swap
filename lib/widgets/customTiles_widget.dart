import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTileWidget extends StatefulWidget {
  final String _assetPath;
  final String _url;

  CustomTileWidget({Key key, @required assetPath, @required url})
      : assert(assetPath != null),
        assert(url != null),
        _url = url,
        _assetPath = assetPath,
        super(key: key);

  State<CustomTileWidget> createState() => _CustomTileWidgeState();
}

class _CustomTileWidgeState extends State<CustomTileWidget> {
  String assetPath;
  String url;

  @override
  void initState() {
    super.initState();
    assetPath = widget._assetPath;
    url = widget._url;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _launchURL();
        },
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
          ),
        ));
  }

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
