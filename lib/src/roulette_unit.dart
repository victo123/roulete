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

import 'roulette_style.dart';

/// Describe a sector area of a [Roulette]
class RouletteUnit {
  const RouletteUnit({
    this.text,
    this.textStyle,
    required this.color,
    required this.weight,
  });

  /// Create a sector with text
  const RouletteUnit.text(
    String text, {
    TextStyle textStyle = RouletteStyle.defaultTextStyle,
    Color color = Colors.blue,
    double weight = 1.0,
  }) : this(text: text, textStyle: textStyle, color: color, weight: weight);

  /// Create a sector with only color but no text
  const RouletteUnit.noText({
    Color color = Colors.blue,
    double weight = 1.0,
  }) : this(color: color, weight: weight);

  /// Text content of this section
  final String? text;

  /// Text style of this section
  final TextStyle? textStyle;

  /// Backgroud color of the sector
  final Color color;

  /// Weight of this sector
  final double weight;
}
