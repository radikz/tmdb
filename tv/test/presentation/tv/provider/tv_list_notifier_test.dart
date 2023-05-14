import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_now_airing_tvs.dart';
import 'package:tv/domain/usecases/tv/get_popular_tvs.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:tv/presentation/tv/provider/tv_list_notifier.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs, GetNowAiringTvs, GetPopularTvs])
void main() {
  late TvListNotifier provider;
  late MockGetNowAiringTvs mockGetNowAiringTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowAiringTvs = MockGetNowAiringTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    provider = TvListNotifier(
        getNowAiringTvs: mockGetNowAiringTvs,
        getPopularTvs: mockGetPopularTvs,
        getTopRatedTvs: mockGetTopRatedTvs)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group("now airing tvs", () {
    test("initial state should be empty", () async {
      expect(provider.airingTodayTvState, equals(RequestState.Empty));
    });

    test("should get data from usecase", () async {
      when(mockGetNowAiringTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));

      provider.fetchAiringTodayTvs();

      verify(mockGetNowAiringTvs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowAiringTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));
      // act
      provider.fetchAiringTodayTvs();
      // assert
      expect(provider.airingTodayTvState, RequestState.Loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetNowAiringTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));
      // act
      await provider.fetchAiringTodayTvs();
      // assert
      expect(provider.airingTodayTvState, RequestState.Loaded);
      expect(provider.airingTodayTvs, <Tv>[testTv]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowAiringTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAiringTodayTvs();
      // assert
      expect(provider.airingTodayTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group("popular tvs", () {
    test("initial state should be empty", () async {
      expect(provider.popularTvState, equals(RequestState.Empty));
    });

    test("should get data from usecase", () async {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));

      provider.fetchPopularTvs();

      verify(mockGetPopularTvs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));
      // act
      provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));
      // act
      await provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTvs, <Tv>[testTv]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvs();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group("top rated tvs", () {
    test("initial state should be empty", () async {
      expect(provider.topRatedTvState, equals(RequestState.Empty));
    });

    test("should get data from usecase", () async {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));

      provider.fetchTopRatedTvs();

      verify(mockGetTopRatedTvs.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));
      // act
      provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvState, RequestState.Loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(<Tv>[testTv]));
      // act
      await provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvState, RequestState.Loaded);
      expect(provider.topRatedTvs, <Tv>[testTv]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvs();
      // assert
      expect(provider.topRatedTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
