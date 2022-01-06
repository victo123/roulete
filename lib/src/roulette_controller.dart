/// Copyright 2021 do9core
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///    http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/material.dart';

import 'roulette_group.dart';
import 'constants.dart';
import 'helpers.dart' hide DoubleSum;

/// Controller for [Roulette] widget.
///
/// [Roulette] widget use [RouletteController] to control the rotate animation
/// and [Roulette]'s display [RouletteGroup].
class RouletteController with ChangeNotifier {
  RouletteController({
    required RouletteGroup group,
    required TickerProvider vsync,
    bool clockwise = true,
  })  : _controller = AnimationController(vsync: vsync),
        _group = group;

  RouletteGroup _group;
  Animation<double>? _animation;
  final AnimationController _controller;

  /// Current rotate animation
  Animation<double> get animation => _animation ?? _controller.drive(Tween(begin: 0, end: 0));

  /// Retrieve current displaying [RouletteGroup]
  RouletteGroup get group => _group;

  /// Set the [RouletteGroup] to refresh widget
  set group(RouletteGroup value) {
    _animation = null;
    _group = value;
    notifyListeners();
    _controller.reset();
  }

  /// Reset animation to initial state
  void resetAnimation() {
    _animation = null;
    notifyListeners();
    _controller.reset();
  }

  /// Stop current running animation
  void stop({bool canceled = true}) {
    _controller.stop(canceled: canceled);
  }

  /// Start an animation to [targetIndex], [targetIndex] item must be in [group].
  /// The [duration] is the animation duration.
  /// The [clockwise] determin whether the animator should run in closewise didrection.
  /// Config [minRotateCircles] to determine the minimum rotate before settle.
  /// Provide a [random] for randomization.
  /// Provide a [curve] to update the animation curve.
  Future<String> rollTo(
    int targetIndex,
    String targetString, {
    Duration duration = defaultDuration,
    int minRotateCircles = defaultMinRotateCircles,
    bool clockwise = true,
    Curve? curve = Curves.fastOutSlowIn,
    double offset = 0,
  }) async {
    final targetRotate = calculateEndRotate(
      group,
      targetIndex,
      clockwise,
      minRotateCircles,
      offset: offset,
    );
    _controller.duration = duration;
    _animation = makeAnimation(_controller, targetRotate, curve);
    notifyListeners();
    await _controller.forward(from: 0);
    return targetString;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
