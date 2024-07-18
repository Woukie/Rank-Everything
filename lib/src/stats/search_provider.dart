import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Thing> _searchResults = List.empty(growable: true);
  bool _ascending = false;
  String _oldQuery = "";

  List<Thing> get searchResults => _searchResults;
  bool get loadingResults => _searchOperation != null;
  bool get ascending => _ascending;

  CancelableOperation? _searchOperation;

  SearchProvider() {
    search("", override: true);
  }

  void setAscending(bool value) {
    _ascending = value;
    notifyListeners();
  }

  Future<void> search(String query, {bool override = false}) async {
    if (query == _oldQuery && !override) return;
    _oldQuery = query;

    if (loadingResults) {
      _searchOperation?.cancel();
    }

    // Prevents old and out-of-order searches from coming through and setting the search results
    _searchOperation = CancelableOperation.fromFuture(() async {
      http.Response response = await http.post(
        Uri.parse('https://rank.woukie.net/search'),
        body: jsonEncode({"query": query, "ascending": _ascending.toString()}),
      );

      List<dynamic> body = jsonDecode(response.body);
      return body.map((value) => Thing.parse(value)).toList();
    }());

    _searchOperation?.then((things) {
      _searchResults = things;
      notifyListeners();
    });
  }

  void refresh() {
    search(_oldQuery, override: true);
  }
}
