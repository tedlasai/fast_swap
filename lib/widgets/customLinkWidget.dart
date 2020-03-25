import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomLinkWidget extends StatefulWidget {
  final String _url;
  final String _name;

  CustomLinkWidget({Key key, @required name, @required url})
      : assert(name != null),
       assert(url != null),
        _name = name,
        _url = url,
        super(key: key);

  State<CustomLinkWidget> createState() => _CustomLinkState();
}

class _CustomLinkState extends State<CustomLinkWidget> {
  String url;
  String name;

  @override
  void initState() {
    super.initState();
    url = widget._url;
    name = widget._name;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _launchURL();
        },
        child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            name,
            style: TextStyle(decoration: TextDecoration.underline, color: Colors.grey),
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
