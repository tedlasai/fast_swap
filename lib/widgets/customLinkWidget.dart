import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomLinkWidget extends StatefulWidget {
  final String _url;
  final String _name;
  final Color _color;

  CustomLinkWidget({Key key, @required name, @required url, @required color})
      : assert(name != null),
        assert(url != null),
        assert(color != null),
        _name = name,
        _url = url,
        _color = color,
        super(key: key);

  State<CustomLinkWidget> createState() => _CustomLinkState();
}

class _CustomLinkState extends State<CustomLinkWidget> {
  String url;
  String name;
  Color textColor;

  @override
  void initState() {
    super.initState();
    url = widget._url;
    name = widget._name;
    textColor = widget._color;
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
            style: TextStyle(
                decoration: TextDecoration.underline, color: textColor),
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
