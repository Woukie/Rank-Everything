import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rank_everything/src/dashboard/thing.dart';
import 'package:http/http.dart' as http;
import 'package:rank_everything/src/settings/settings_provider.dart';

enum GameState { idle, starting, choosing, chosen }

class ThingProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late final SettingsProvider _settingsProvider;

  int _selectedThing = 0;
  bool _expectingThingsFromServer = false;
  Thing? _thing1, _thing2;

  Thing? get thing1 => _thing1;
  Thing? get thing2 => _thing2;

  GameState get gameState {
    bool thingsLoaded = thing1 != null && thing2 != null;

    if (!thingsLoaded) {
      return !_expectingThingsFromServer ? GameState.idle : GameState.starting;
    }

    return selectedThing == 0 ? GameState.choosing : GameState.chosen;
  }

  /// Currently chosen thing, 0 corresponding to unselected
  int get selectedThing => _selectedThing;

  ThingProvider(SettingsProvider settingsProvider) {
    _settingsProvider = settingsProvider;
  }

  /// Resets things and selection, then fetches the next two things
  Future<void> loadNextThings() async {
    if (_expectingThingsFromServer) return;

    _thing1 = null;
    _thing2 = null;
    _selectedThing = 0;
    _expectingThingsFromServer = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 250));

    http.Response response = await http.get(Uri.parse(
        'https://rank.woukie.net/get_comparison/${_settingsProvider.nsfw != NsfwMode.hidden}'));

    dynamic body = jsonDecode(response.body);

    _thing1 = Thing.parse(body[0]);
    _thing2 = Thing.parse(body[1]);

    _expectingThingsFromServer = false;

    notifyListeners();
  }

  /// Takes either 1 or 2, corresponding to either the first or second thing
  Future<void> selectThing(int thing) async {
    _selectedThing = thing;

    notifyListeners();

    bool top = _selectedThing == 1;

    int likeId = top ? _thing1!.id : _thing2!.id;
    int dislikeId = top ? _thing2!.id : _thing1!.id;

    await http.post(
      Uri.parse('https://rank.woukie.net/submit_vote'),
      body: jsonEncode(
          {"like": likeId.toString(), "dislike": dislikeId.toString()}),
    );
  }

  Thing? getThingFromID(int id) {
    return id == 1 ? _thing1 : _thing2;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('thing 1', _thing1?.name));
    properties.add(StringProperty('thing 2', _thing2?.name));
    properties.add(IntProperty('selected thing', _selectedThing));
  }
}
