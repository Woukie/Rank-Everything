import 'package:flutter/foundation.dart';
import 'package:rank_everything/src/dashboard/thing.dart';

enum GameState { idle, starting, choosing, chosen }

class ThingProvider with ChangeNotifier, DiagnosticableTreeMixin {
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

  /// Resets things and selection, then fetches the next two things
  Future<void> loadNextThings() async {
    if (_expectingThingsFromServer) return;

    _thing1 = null;
    _thing2 = null;
    _selectedThing = 0;
    _expectingThingsFromServer = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _thing1 = Thing(
      id: 0,
      name: "Bread",
      imageUrl:
          "https://www.cookingclassy.com/wp-content/uploads/2020/04/bread-recipe-1.jpg",
      description: "The food",
      votes: 123,
      adult: false,
    );

    _thing2 = Thing(
      id: 1,
      name: "Mercury Poisoning",
      imageUrl:
          "https://www.ancient-symbols.com/wp-content/uploads/2019/11/mercury-metal.jpg",
      description: "Kills you",
      votes: 1102,
      adult: false,
    );

    _expectingThingsFromServer = false;

    notifyListeners();

    // TODO: some code...
  }

  Future<void> selectThing(int thing) async {
    _selectedThing = thing;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('thing 1', _thing1?.name));
    properties.add(StringProperty('thing 2', _thing2?.name));
    properties.add(IntProperty('selected thing', _selectedThing));
  }
}
