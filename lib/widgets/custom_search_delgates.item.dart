import 'package:flutter/material.dart';
import 'package:read_it_later/screens/search_book.page.dart';

typedef OnSearchChanged = Future<List<String>> Function(String);

class SearchWithSuggestionDelegate extends SearchDelegate<String> {
  ///[onSearchChanged] gets the [query] as an argument. Then this callback
  ///should process [query] then return an [List<String>] as suggestions.
  ///Since its returns a [Future] you get suggestions from server too.
  final OnSearchChanged onSearchChanged;

  ///This [_oldFilters] used to store the previous suggestions. While waiting
  ///for [onSearchChanged] to completed, [_oldFilters] are displayed.
  List<String> _oldFilters = const [];

  SearchWithSuggestionDelegate({String searchFieldLabel, this.onSearchChanged})
      : super(searchFieldLabel: searchFieldLabel);

  ///
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = super.appBarTheme(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        actionsIconTheme: IconThemeData(color: Theme.of(context).accentColor),
        
      ),
      inputDecorationTheme: InputDecorationTheme(hintStyle: Theme.of(context).textTheme.headline6.copyWith(color:Theme.of(context).textTheme.bodyText1.color, fontSize: 16), border: InputBorder.none),
      textTheme: TextTheme(headline6: TextStyle(fontSize: 16, color:Theme.of(context).textTheme.bodyText1.color))
    );
  }

  ///OnSubmit in the keyboard, returns the [query]
  @override
  void showResults(BuildContext context) {
    close(context, query);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchBookPage(searchTerm: query)));
  }

  ///Since [showResults] is overridden we can don't have to build the results.
  @override
  Widget buildResults(BuildContext context) => null;

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: onSearchChanged != null ? onSearchChanged(query) : null,
      builder: (context, snapshot) {
        if (snapshot.hasData) _oldFilters = snapshot.data;
        return ListView.builder(
          itemCount: _oldFilters.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.restore, color: Theme.of(context).accentColor,),
              title: Text("${_oldFilters[index]}", style: TextStyle(color: Theme.of(context).accentColor),),
              onTap: () {
                close(context, _oldFilters[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchBookPage(searchTerm: _oldFilters[index])));
              },
            );
          },
        );
      },
    );
  }
}
