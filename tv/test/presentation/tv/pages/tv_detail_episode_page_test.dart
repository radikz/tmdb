import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/tv/bloc/episode_detail/episode_detail_tv_bloc.dart';
import 'package:tv/presentation/tv/pages/tv_detail_episode_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockEpisodeDetailTvBloc extends MockBloc<EpisodeDetailTvEvent, EpisodeDetailTvState>
    implements EpisodeDetailTvBloc {}

void main() {
  late MockEpisodeDetailTvBloc mockBloc;

  setUp(() {
    mockBloc = MockEpisodeDetailTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<EpisodeDetailTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Episode Tv', () {
    testWidgets("Episode tv is loading", (tester) async {
      when(() => mockBloc.state).thenReturn(EpisodeDetailTvLoading());
      final loadingWidget = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvDetailEpisodePage(
        arg: TvDetailEpisodeArg(tvId: 1, seasonNumber: 1, episodeNumber: 1),
      )));

      expect(loadingWidget, findsOneWidget);
    });

    testWidgets("episode tv is error", (tester) async {
      when(() => mockBloc.state).thenReturn(EpisodeDetailTvFailure("error"));
      final errorWidget = find.byKey(ValueKey("__episode_error__tv"));

      await tester.pumpWidget(_makeTestableWidget(TvDetailEpisodePage(
        arg: TvDetailEpisodeArg(tvId: 1, seasonNumber: 1, episodeNumber: 1),
      )));

      expect(errorWidget, findsOneWidget);
    });

    testWidgets("episode tv is loaded", (tester) async {
      when(() => mockBloc.state).thenReturn(EpisodeDetailTvLoaded(testTvEpisode));
      final content = find.byType(DetailContentEpisode);

      await tester.pumpWidget(_makeTestableWidget(TvDetailEpisodePage(
        arg: TvDetailEpisodeArg(tvId: 1, seasonNumber: 1, episodeNumber: 1),
      )));

      expect(content, findsOneWidget);
    });
  });
}
