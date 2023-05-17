import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/popular/popular_tv_bloc.dart';
import 'package:tv/presentation/tv/pages/airing_now_tvs_page.dart';
import 'package:tv/presentation/tv/pages/popular_tvs_page.dart';
import 'package:tv/presentation/tv/provider/airing_now_tvs_notifier.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

void main() {
  late MockPopularTvBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  group('when data is loaded', () {
    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(PopularTvLoaded(<Tv>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display item when loaded',
        (WidgetTester tester) async {
      when(() => mockBloc.state).thenReturn(PopularTvLoaded(<Tv>[testTv]));

      final itemFinder = find.byType(TvCard);

      await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

      expect(itemFinder, findsOneWidget);
    });
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(PopularTvFailure("Error message"));

    final textFinder = find.byKey(Key('error_message_tv'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
