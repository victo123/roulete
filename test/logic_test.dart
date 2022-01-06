import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roulette/roulette.dart';
import 'package:roulette/src/helpers.dart';
import 'package:roulette/src/roulette_paint.dart';

import 'test_component.dart';

void main() {
  group('helpers tests', () {
    group('calculate end rotate test', () {
      test('ensure end rotate on target unit with no offset, clockwise', () {
        final group = RouletteGroup.uniform(5);
        final actual = calculateEndRotate(group, 0, true, 0);
        expect(actual, 4 / 5 * pi * 2);
      });

      test('ensure end rotate on target unit with offset, clockwise', () {
        final group = RouletteGroup.uniform(5);
        final actual = calculateEndRotate(group, 0, true, 0, offset: 1);
        expect(actual, pi * 2);
      });

      test('ensure end rotate on target unit with no offset, not clockwise', () {
        final group = RouletteGroup.uniform(5);
        final actual = calculateEndRotate(group, 0, false, 0);
        expect(actual, 0.0);
      });

      test('ensure end rotate on target unit with offset, not clockwise', () {
        final group = RouletteGroup.uniform(5);
        final actual = calculateEndRotate(group, 0, true, 0, offset: 1);
        expect(actual, pi * 2);
      });
    });
  });

  group('controller tests', () {
    testWidgets(
      'ensure rollTo settle at target index',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          RouletteWidgetTest(group: RouletteGroup.uniform(5)),
        );
        final state = tester.state<RouletteWidgetTestState>(find.byType(RouletteWidgetTest));
        const minCircles = 3;
        state.controller.rollTo(1, "", minRotateCircles: minCircles);
        await tester.pumpAndSettle();
        final animation = state.controller.animation;
        print(animation.value);
        print((minCircles + 3 / 5) * pi * 2);
        print(minCircles);
        print(pi);
        expect(animation.value, (minCircles + 3 / 5) * pi * 2);
      },
    );
  });

  group('widget display tests', () {
    testWidgets(
      'ensure roulette displayed',
      (WidgetTester tester) async {
        final group = RouletteGroup.uniform(
          5,
          textBuilder: (index) => '$index',
          colorBuilder: (index) => Colors.pink,
        );
        final controller = RouletteController(group: group, vsync: tester);
        await tester.pumpWidget(Roulette(controller: controller));
        expect(find.byType(RoulettePaint), findsOneWidget);
      },
    );
  });
}
