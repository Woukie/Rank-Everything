import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:rank_everything/src/dashboard/thing.dart';

class ThingProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _selectedThing = 0;
  Thing? _thing1, _thing2;

  Thing? get thing1 => _thing1;
  Thing? get thing2 => _thing2;

  /// Currently chosen thing, 0 corresponding to unselected
  int get selectedThing => _selectedThing;

  /// Resets things and selection, then fetches the next two things
  Future<void> loadNextThings() async {
    _thing1 = null;
    _thing2 = null;
    _selectedThing = 0;
    notifyListeners();

    sleep(const Duration(seconds: 2));

    _thing1 = Thing(
      name: "Bread",
      image:
          "https://www.cookingclassy.com/wp-content/uploads/2020/04/bread-recipe-1.jpg",
      description: "The shit you eat",
      votes: 123,
    );

    _thing1 = Thing(
      name: "Mercury Poisoning",
      image:
          "https://cdn-01.media-brady.com/store/stus/media/catalog/product/cache/4/image/85e4522595efc69f496374d01ef2bf13/1617235180/c/h/chemical-ghs-signs-mercury-l8565-lg.jpg",
      description: "Kills you",
      votes: 1102,
    );

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
