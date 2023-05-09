import 'package:core/utils/state_enum.dart';
import 'package:ditonton/presentation/tv/pages/tv_season_page.dart';
import 'package:ditonton/presentation/tv/provider/season_detail_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_season_page_test.mocks.dart';

@GenerateMocks([SeasonDetailTvNotifier])
void main() {
  late MockSeasonDetailTvNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSeasonDetailTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SeasonDetailTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Season Tv', () {
    testWidgets("Season tv is loading", (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);
      final loadingWidget = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(
          TvSeasonPage(arg: TvSeasonArg(tvId: 1, seasonNumber: 1))));

      expect(loadingWidget, findsOneWidget);
    });

    testWidgets("season tv is error", (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn("error");
      final errorWidget = find.byKey(ValueKey("__season_error__tv"));

      await tester.pumpWidget(_makeTestableWidget(
          TvSeasonPage(arg: TvSeasonArg(tvId: 1, seasonNumber: 1))));

      expect(errorWidget, findsOneWidget);
    });

    testWidgets("season tv is loaded", (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.season).thenReturn(testDetailSeason);
      final content = find.byType(SeasonContent);

      await tester.pumpWidget(_makeTestableWidget(
          TvSeasonPage(arg: TvSeasonArg(tvId: 1, seasonNumber: 1))));

      expect(content, findsOneWidget);
    });
  });
}
