import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_airing_tvs.dart';
import 'package:ditonton/presentation/tv/provider/airing_now_tvs_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'airing_now_tvs_notifier_test.mocks.dart';

@GenerateMocks([GetNowAiringTvs])
void main() {
  late MockGetNowAiringTvs mockGetNowAiringTvs;
  late AiringNowTvsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    mockGetNowAiringTvs = MockGetNowAiringTvs();
    notifier = AiringNowTvsNotifier(mockGetNowAiringTvs)
      ..addListener(() {
        listenerCallCount++;
      });
    listenerCallCount = 0;
  });

  final testTvList = <Tv>[testTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowAiringTvs.execute())
        .thenAnswer((_) async => Right(testTvList));
    // act
    notifier.fetchAiringNowTvs();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowAiringTvs.execute())
        .thenAnswer((_) async => Right(testTvList));
    // act
    await notifier.fetchAiringNowTvs();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, testTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowAiringTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchAiringNowTvs();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
