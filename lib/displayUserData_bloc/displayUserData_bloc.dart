import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastswap/displayUserData_bloc/displayUserData.dart';
import 'package:fastswap/usersLib/src/entities/entities.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:meta/meta.dart';
import 'package:fastswap/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastswap/usersLib/users_repository.dart';

class DisplayUserDataBloc
    extends Bloc<DisplayUserDataEvent, DisplayUserDataState> {
  UsersRepository _usersRepository;

  DisplayUserDataBloc({@required UsersRepository usersRepository})
      : assert(usersRepository != null),
        _usersRepository = usersRepository {
    initDynamicLinks();
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    print(deepLink);
    if (deepLink != null) {
      add(DisplayUserDataUpdatedByLink(link: deepLink.toString(), deep: true));
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      print("DEEPLINK: $dynamicLink");
      print("DYNAMIC LINK FOUND");
      if (deepLink != null) {
        add(DisplayUserDataUpdatedByLink(
            link: deepLink.toString(), deep: true));
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  @override
  DisplayUserDataState get initialState => NoUserData();

  @override
  Stream<DisplayUserDataState> mapEventToState(
    DisplayUserDataEvent event,
  ) async* {
    if (event is DisplayUserDataStarted) {
      yield* _mapDisplayUserDataStartedToState();
    } else if (event is DisplayUserDataUpdated) {
      yield* _mapDisplayUserDataUpdatedToState(event);
    } else if (event is DisplayUserDataUpdatedByLink) {
      yield* _mapDisplayUserDataUpdatedByLink(event);
    } else if (event is DisplayUserDataClear) {
      yield* _mapDisplayUserDataClearToState();
    }
  }

  Stream<DisplayUserDataState> _mapDisplayUserDataStartedToState() async* {
    yield NoUserData();
  }

  Stream<DisplayUserDataState> _mapDisplayUserDataUpdatedToState(
      DisplayUserDataUpdated event) async* {
    yield HasUserData(event.data);
  }

  Stream<DisplayUserDataState> _mapDisplayUserDataUpdatedByLink(
      DisplayUserDataUpdatedByLink event) async* {
    //parseUrl
    String username = "";
    if (event.deep) {
      //deep link
      username = parseDeepLink(event.link);
    } else {
      //dynamic link
      username = parseDynamicLink(event.link);
    }
    try {
      User user;

      QuerySnapshot usersMatchedSnapshot =
          await _usersRepository.findUsername(username);

      List<User> usersMatched = usersMatchedSnapshot.documents
          .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();

      if (usersMatched.length > 0) {
        user = usersMatched[0];
        yield HasUserData(user);
      } else {
        yield NoUserData();
      }
    } catch (_) {
      yield NoUserData();
    }
  }

  String parseDynamicLink(String dynamicLink) {
    Uri dynamicLinkURI = Uri.parse(dynamicLink);
    Uri LinkURI = Uri.parse(dynamicLinkURI.queryParameters["link"]);
    return LinkURI.queryParameters["username"];
  }

  Stream<DisplayUserDataState> _mapDisplayUserDataClearToState() async* {
    yield NoUserData();
  }

  String parseDeepLink(String deepLink) {
    return Uri.parse(deepLink).queryParameters["username"];
  }
}
