import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:rank_everything/src/dashboard/thing.dart';

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

        // TODO: Return list of things from server

        return List.empty();
      }(),
      onCancel: () {
        debugPrint('Cancelled old search');
        notifyListeners();
      },
    );

    _fetchSearch?.then(
      (things) {
        print(things);
      },
    );
  }
}
