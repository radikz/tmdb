import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:ditonton/presentation/tv/provider/season_detail_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'season_detail_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTvDetailSeason])
void main() {
  late MockGetTvDetailSeason mockGetTvDetailSeason;
  late SeasonDetailTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    mockGetTvDetailSeason = MockGetTvDetailSeason();
    notifier = SeasonDetailTvNotifier(mockGetTvDetailSeason)
      ..addListener(() {
        listenerCallCount++;
      });
    listenerCallCount = 0;
  });


  test('loading data', () {
    when(mockGetTvDetailSeason.execute(1, 1))
        .thenAnswer((_) async => Right(testDetailSeason));

    notifier.fetchSeason(tvId: 1, seasonNumber: 1);

    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('data loaded', () async {
    when(mockGetTvDetailSeason.execute(1, 1))
        .thenAnswer((_) async => Right(testDetailSeason));

    await notifier.fetchSeason(tvId: 1, seasonNumber: 1);

    expect(notifier.state, RequestState.Loaded);
    expect(notifier.season, testDetailSeason);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetTvDetailSeason.execute(1, 1))
        .thenAnswer((_) async => Left(ServerFailure("Server Failure")));

    await notifier.fetchSeason(tvId: 1, seasonNumber: 1);

    expect(notifier.state, RequestState.Error);
    expect(notifier.message, "Server Failure");
    expect(listenerCallCount, 2);
  });
}