import 'package:flutter/material.dart';
import 'package:read_it_later/widgets/custom_search_delgates.item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchDelgateHandler {

  Future<void> handlerShowSearch(BuildContext context) async {
    final searchText = await showSearch<String>(
      context: context,
      delegate: SearchWithSuggestionDelegate(
        onSearchChanged: handlerGetRecentSearchesLike,
      ),
    );

    //Save the searchText to SharedPref so that next time you can use them as recent searches.
    await handlerSaveToRecentSearches(searchText);

    //Do something with searchText. Note: This is not a result.
  }

  Future<List<String>> handlerGetRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches");
    return allSearches.where((search) => search.startsWith(query)).toList();
  }

  Future<void> handlerSaveToRecentSearches(String searchText) async {
    if (searchText == null) return; //Should not be null
    final pref = await SharedPreferences.getInstance();

    //Use `Set` to avoid duplication of recentSearches
    Set<String> allSearches =
        pref.getStringList("recentSearches")?.toSet() ?? {};

    //Place it at first in the set
    allSearches = {searchText, ...allSearches};
    pref.setStringList("recentSearches", allSearches.toList());
  }

}