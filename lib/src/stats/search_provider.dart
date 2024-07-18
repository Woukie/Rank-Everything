import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final List<Thing> _searchResults = List.empty(growable: true);
  String _oldQuery = "";

  List<Thing> get searchResults => _searchResults;
  bool get loadingResults => _fetchSearch != null;

  CancelableOperation? _fetchSearch;

  Future<void> search(String query) async {
    if (query == _oldQuery) return;
    _oldQuery = query;

    if (loadingResults) {
      _fetchSearch!.cancel();
    }

    _fetchSearch = CancelableOperation.fromFuture(
      () async {
        await Future.delayed(const Duration(milliseconds: 700));

        http.Response response = await http.post(
          Uri.parse('https://rank.woukie.net/search'),
          body: {"search": query, "ascending": true},
        );

        Map<String, dynamic> body = jsonDecode(response.body);

        return body.values.map((value) => Thing.parse(value)).toList();
      }(),
    );

    _fetchSearch?.then(
      (things) {
        print(things);
        notifyListeners();
      },
    );
  }
}
