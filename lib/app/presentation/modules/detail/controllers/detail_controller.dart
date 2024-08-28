import 'package:flutter/material.dart';
import 'package:shoes_app/app/domain/models/shoe_model.dart';
import 'package:shoes_app/app/presentation/modules/detail/states/detail_state.dart';

class DetailController with ChangeNotifier {
  late DetailState _state;

  DetailController({required DetailState state}) : _state = state;

  DetailState get state => _state;

  void _updateState(DetailState newState, {bool notify = true}) {
    _state = newState;
    if (notify) notifyListeners();
  }

  void updateSelectedColor(ShoesColors color) {
    _updateState(
      _state.copyWith(
        selectedColor: color,
      ),
    );
  }
}
