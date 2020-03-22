import 'package:fastswap/search_bloc/search.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fastswap/tab/app_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabSelector extends StatefulWidget {
  const TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  @override
  _TabSelector createState() => _TabSelector();
}

class _TabSelector extends State<TabSelector> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(widget.activeTab),
      onTap: (index) => widget.onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.home ? Icons.list : Icons.show_chart,
          ),
          title: Text(
            tab == AppTab.home ? 'Home' : 'Account',
          ),
        );
      }).toList(),
    );
  }

  _clearState() {
    //BlocProvider.of<SearchBloc>(context).add(SearchUpdated(query: ""));
  }
}
