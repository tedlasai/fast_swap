import 'package:fastswap/search_bloc/search.dart';
import 'package:fastswap/usersLib/src/models/user.dart';
import 'package:fastswap/users_bloc/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';

class HomeWidget extends StatefulWidget {
  final String _uid;
  final String _displayName;

  HomeWidget({Key key, @required displayName, @required uid})
      : assert(uid != null),
        assert(displayName != null),
        _uid = uid,
        _displayName = displayName,
        super(key: key);

  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String uid;
  String displayName;
  String whatsapp;
  List<User> usersMatched;
  String searchStateDecision;

  @override
  void initState() {
    super.initState();
    uid = widget._uid;
    displayName = widget._displayName;
    usersMatched = [];
    searchStateDecision = "EMPTY";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
      return BlocBuilder<SearchBloc, SearchState>(
          builder: (searchContext, searchState) {
        if (searchState is HasSearchStringAndResults) {
          usersMatched = searchState.usersMatched;
        } else {
          usersMatched = [];
        }
        if (!searchState.hasQuery) {
          searchStateDecision = "EMPTY";
        } else if (usersMatched.length == 0) {
          searchStateDecision = "NO MATCHES";
        } else {
          searchStateDecision = "HAS RESULTS";
        }
        print("SEARCH STATE DECISION");
        print(searchStateDecision);
        if (state is UserInfoLoaded) {
          print(state.userInfo);
        }
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // in the build method
              ConditionalSwitch.single<String>(
                context: context,
                valueBuilder: (BuildContext context) => searchStateDecision,
                caseBuilders: {
                  'EMPTY': (BuildContext context) => Text(
                      'EDIT INFO PAGE Welcome $displayName! UserID: $uid Whatsapp: $whatsapp.'),
                  'NO MATCHES': (BuildContext context) =>
                      Text('There are no matches'),
                },
                fallbackBuilder: (BuildContext context) => Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: usersMatched.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                usersMatched[index].displayName,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                usersMatched[index].username,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ]);
      });
    });
  }
}
