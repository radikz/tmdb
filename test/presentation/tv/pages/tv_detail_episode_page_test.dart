import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/tv/pages/tv_detail_episode_page.dart';
import 'package:ditonton/presentation/tv/provider/episode_detail_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_episode_page_test.mocks.dart';

@GenerateMocks([EpisodeDetailTvNotifier])
void main() {
  late MockEpisodeDetailTvNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockEpisodeDetailTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<EpisodeDetailTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Episode Tv', () {
    testWidgets("Episode tv is loading", (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);
      final loadingWidget = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvDetailEpisodePage(
        arg: TvDetailEpisodeArg(tvId: 1, seasonNumber: 1, episodeNumber: 1),
      )));

      expect(loadingWidget, findsOneWidget);
    });

    testWidgets("episode tv is error", (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn("error");
      final errorWidget = find.byKey(ValueKey("__episode_error__tv"));

      await tester.pumpWidget(_makeTestableWidget(TvDetailEpisodePage(
        arg: TvDetailEpisodeArg(tvId: 1, seasonNumber: 1, episodeNumber: 1),
      )));

      expect(errorWidget, findsOneWidget);
    });

    testWidgets("episode tv is loaded", (tester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.episodes).thenReturn(testTvEpisode);
      final content = find.byType(DetailContentEpisode);

      await tester.pumpWidget(_makeTestableWidget(TvDetailEpisodePage(
        arg: TvDetailEpisodeArg(tvId: 1, seasonNumber: 1, episodeNumber: 1),
      )));

      expect(content, findsOneWidget);
    });
  });
}
