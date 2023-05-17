import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';
import 'package:tv/presentation/tv/pages/airing_now_tvs_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockAiringNowTvBloc extends MockBloc<AiringNowTvEvent, AiringNowTvState>
    implements AiringNowTvBloc {}

void main() {
  late MockAiringNowTvBloc mockBloc;

  setUp(() {
    mockBloc = MockAiringNowTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<AiringNowTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(AiringNowTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const AiringNowTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  group('when data is loaded', () {
    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(const AiringNowTvLoaded(<Tv>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const AiringNowTvsPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display item when loaded',
        (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(AiringNowTvLoaded(<Tv>[testTv]));

      final itemFinder = find.byType(TvCard);

      await tester.pumpWidget(_makeTestableWidget(const AiringNowTvsPage()));

      expect(itemFinder, findsOneWidget);
    });
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const AiringNowTvFailure("Error message"));

    final textFinder = find.byKey(const Key('error_message_tv'));

    await tester.pumpWidget(_makeTestableWidget(const AiringNowTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
