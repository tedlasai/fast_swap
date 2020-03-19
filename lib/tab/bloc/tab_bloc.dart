import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fastswap/tab/bloc/tab.dart';
import 'package:fastswap/tab/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.home;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}