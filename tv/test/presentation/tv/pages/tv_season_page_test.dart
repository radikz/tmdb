import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/tv/bloc/season_detail/season_detail_tv_bloc.dart';
import 'package:tv/presentation/tv/pages/tv_season_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockSeasonDetailTvBloc
    extends MockBloc<SeasonDetailTvEvent, SeasonDetailTvState>
    implements SeasonDetailTvBloc {}

void main() {
  late MockSeasonDetailTvBloc mockBloc;

  setUp(() {
    mockBloc = MockSeasonDetailTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeasonDetailTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Season Tv', () {
    testWidgets("Season tv is loading", (tester) async {
      when(() => mockBloc.state).thenReturn(SeasonDetailTvLoading());
      final loadingWidget = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(
          TvSeasonPage(arg: TvSeasonArg(tvId: 1, seasonNumber: 1))));

      expect(loadingWidget, findsOneWidget);
    });

    testWidgets("season tv is error", (tester) async {
      when(() => mockBloc.state)
          .thenReturn(const SeasonDetailTvFailure("error"));
      final errorWidget = find.byKey(const ValueKey("__season_error__tv"));

      await tester.pumpWidget(_makeTestableWidget(
          TvSeasonPage(arg: TvSeasonArg(tvId: 1, seasonNumber: 1))));

      expect(errorWidget, findsOneWidget);
    });

    testWidgets("season tv is loaded", (tester) async {
      when(() => mockBloc.state)
          .thenReturn(SeasonDetailTvLoaded(testDetailSeason));
      final content = find.byType(SeasonContent);

      await tester.pumpWidget(_makeTestableWidget(
          TvSeasonPage(arg: TvSeasonArg(tvId: 1, seasonNumber: 1))));

      expect(content, findsOneWidget);
    });
  });
}
