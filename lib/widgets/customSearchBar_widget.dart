import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastswap/search_bloc/search.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget implements PreferredSizeWidget {
  CustomSearchBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final queryController = TextEditingController();

  bool textEmpty;

  @override
  void initState() {
    super.initState();
    textEmpty = true;
    queryController.addListener(_updateQuery);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return AppBar(
          title: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(50, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(22.0))),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: TextFormField(
                            style: new TextStyle(color: Colors.white),
                            controller: queryController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Find Friend By Username",
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white),
                              suffixIcon: Visibility(
                                visible: state.hasQuery,
                                child: IconButton(
                                    icon:
                                        Icon(Icons.cancel, color: Colors.white),
                                    onPressed: _clearQueryController),
                              ),
                            ))),
                  ])));
    });
  }

  _updateQuery() {
    print("TWICE");
    textEmpty = queryController.text == "";
    BlocProvider.of<SearchBloc>(context)
        .add(SearchUpdated(query: queryController.text));
  }

  _clearQueryController() {
    BlocProvider.of<SearchBloc>(context).add(SearchClear());
    //queryController.text = "";
    //filterNod
    FocusScope.of(context).requestFocus(FocusNode()); //hide keyboard
    queryController.clear();
    //FocusScope.of(context).requestFocus(FocusNode());
  }
}
