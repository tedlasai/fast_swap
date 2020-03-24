import 'package:fastswap/displayUserData_bloc/displayUserData.dart';
import 'package:fastswap/tab/app_tab.dart';
import 'package:fastswap/tab/bloc/tab.dart';
import 'package:fastswap/usersLib/src/models/user.dart';
import 'package:fastswap/widgets/customTiles_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayUserDataScreen extends StatelessWidget {
  @override
  User data;
  String twitter;
  String displayname;
  String facebook;
  String snapchat;
  String instagram;
  String phoneNumber;
  String email;

  bool notNull(Object o) => o != null;

  Widget build(BuildContext context) {
    return BlocBuilder<DisplayUserDataBloc, DisplayUserDataState>(
        builder: (displayUserContext, displayUserDataState) {
      data = displayUserDataState.data;
      twitter = data.twitter;
      displayname = data.displayName;
      facebook = data.facebook;
      snapchat = data.snapchat;
      instagram = data.instagram;
      email = data.email;
      phoneNumber = data.phoneNumber;

      return Scaffold(
        appBar: AppBar(
            title: Text(displayname),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<DisplayUserDataBloc>(context)
                    .add(DisplayUserDataClear());

                // BlocProvider.of<TabBloc>(context).add(
                //   UpdateTab(AppTab.home)); //reset to home next time you log in
              },
            )),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            checkIfFieldExists(phoneNumber)
                ? CustomTileWidget(
                    assetPath: "assets/phone.png", url: "tel:$phoneNumber")
                : null,
            checkIfFieldExists(email)
                ? CustomTileWidget(
                    assetPath: "assets/email.png", url: "mailto:$email")
                : null,
            checkIfFieldExists(snapchat)
                ? CustomTileWidget(
                    assetPath: "assets/snapchat.png",
                    url: "https://snapchat.com/add/$snapchat")
                : null,
            checkIfFieldExists(instagram)
                ? CustomTileWidget(
                    assetPath: "assets/instagram.png",
                    url: "https://instagram.com/$instagram")
                : null,
            checkIfFieldExists(facebook)
                ? CustomTileWidget(
                    assetPath: "assets/facebook.png",
                    url: "https://fb.me/$facebook")
                : null,
            checkIfFieldExists(twitter)
                ? CustomTileWidget(
                    assetPath: "assets/twitter.png",
                    url: "https://twitter.com/$twitter")
                : null,
          ].where(notNull).toList(),
        ),
      );
    });
  }

  bool checkIfFieldExists(String field) {
    return field != null && field.length > 0;
  }
}
