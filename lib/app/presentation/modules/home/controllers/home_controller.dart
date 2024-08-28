import 'package:flutter/material.dart';

import '../states/home_state.dart';

class HomeController with ChangeNotifier {
  late HomeState _homeState;

  HomeController({required HomeState state}) : _homeState = state;

  HomeState get homeState => _homeState;

  void _updateState(HomeState newState, {bool notify = true}) {
    _homeState = newState;
    if (notify) notifyListeners();
  }

  void updateSelectedSize(String number) {
    _updateState(
      _homeState.copyWith(
        selectedSize: number,
      ),
    );
  }
}
