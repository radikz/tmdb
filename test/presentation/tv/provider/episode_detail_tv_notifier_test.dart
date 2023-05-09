import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_episode.dart';
import 'package:ditonton/presentation/tv/provider/episode_detail_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'episode_detail_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTvDetailEpisode])
void main() {
  late MockGetTvDetailEpisode mockGetTvDetailSeason;
  late EpisodeDetailTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    mockGetTvDetailSeason = MockGetTvDetailEpisode();
    notifier = EpisodeDetailTvNotifier(mockGetTvDetailSeason)
      ..addListener(() {
        listenerCallCount++;
      });
    listenerCallCount = 0;
  });

  test('loading data', () {
    when(mockGetTvDetailSeason.execute(1, 1, 1))
        .thenAnswer((_) async => Right(testTvEpisode));

    notifier.fetchEpisode(tvId: 1, seasonNumber: 1, episodeNumber: 1);

    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('data loaded', () async {
    when(mockGetTvDetailSeason.execute(1, 1, 1))
        .thenAnswer((_) async => Right(testTvEpisode));

    await notifier.fetchEpisode(tvId: 1, seasonNumber: 1, episodeNumber: 1);

    expect(notifier.state, RequestState.Loaded);
    expect(notifier.episodes, testTvEpisode);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetTvDetailSeason.execute(1, 1, 1))
        .thenAnswer((_) async => Left(ServerFailure("Server Failure")));

    await notifier.fetchEpisode(tvId: 1, seasonNumber: 1, episodeNumber: 1);

    expect(notifier.state, RequestState.Error);
    expect(notifier.message, "Server Failure");
    expect(listenerCallCount, 2);
  });
}
