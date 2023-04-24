import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:ditonton/presentation/tv/provider/watchlist_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late MockGetWatchlistTvs mockSearchTvs;
  late WatchlistTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    mockSearchTvs = MockGetWatchlistTvs();
    notifier = WatchlistTvNotifier(mockSearchTvs)
      ..addListener(() {
        listenerCallCount++;
      });
    listenerCallCount = 0;
  });

  final testListTv = <Tv>[testTv];

  test('loading data', () {
    when(mockSearchTvs.execute())
        .thenAnswer((_) async => Right(testListTv));

    notifier.fetchWatchlistTvs();

    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('data loaded', () async {
    when(mockSearchTvs.execute())
        .thenAnswer((_) async => Right(testListTv));

    await notifier.fetchWatchlistTvs();

    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, testListTv);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockSearchTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure("Server Failure")));

    await notifier.fetchWatchlistTvs();

    expect(notifier.state, RequestState.Error);
    expect(notifier.message, "Server Failure");
    expect(listenerCallCount, 2);
  });
}
