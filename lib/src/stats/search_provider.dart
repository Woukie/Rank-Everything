import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Thing> _searchResults = List.empty(growable: true);
  String _oldQuery = "";

  List<Thing> get searchResults => _searchResults;
  bool get loadingResults => _searchOperation != null;

  CancelableOperation? _searchOperation;

  SearchProvider() {
    search("");
  }

  Future<void> search(String query) async {
    if (query == _oldQuery) return;
    _oldQuery = query;

    if (loadingResults) {
      _searchOperation?.cancel();
    }

    // Prevents old and out-of-order searches from coming through and setting the search results
    _searchOperation = CancelableOperation.fromFuture(() async {
      http.Response response = await http.post(
        Uri.parse('https://rank.woukie.net/search'),
        body: jsonEncode({"query": query, "ascending": "false"}),
      );

      List<dynamic> body = jsonDecode(response.body);
      return body.map((value) => Thing.parse(value)).toList();
    }());

    _searchOperation?.then((things) {
      _searchResults = things;
      notifyListeners();
    });
  }
}
