import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/tv/data/models/tv_model.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource remoteDataSource;
  late MockTvLocalDataSource localDataSource;

  setUp(() {
    localDataSource = MockTvLocalDataSource();
    remoteDataSource = MockTvRemoteDataSource();
    repository = TvRepositoryImpl(
        localDataSource: localDataSource, remoteDataSource: remoteDataSource);
  });

  final tTvModelList = <TvModel>[testTvModel];
  final tTvList = <Tv>[testTv];

  group('Get Airing Now Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(remoteDataSource.getNowAiringTvs())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getNowAiringTvs();

      verify(remoteDataSource.getNowAiringTvs());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(remoteDataSource.getNowAiringTvs()).thenThrow(ServerException());

      final result = await repository.getNowAiringTvs();

      verify(remoteDataSource.getNowAiringTvs());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(remoteDataSource.getNowAiringTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getNowAiringTvs();

      verify(remoteDataSource.getNowAiringTvs());
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Top Rated Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(remoteDataSource.getTopRatedTvs())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getTopRatedTvs();

      verify(remoteDataSource.getTopRatedTvs());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(remoteDataSource.getTopRatedTvs()).thenThrow(ServerException());

      final result = await repository.getTopRatedTvs();

      verify(remoteDataSource.getTopRatedTvs());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(remoteDataSource.getTopRatedTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTopRatedTvs();

      verify(remoteDataSource.getTopRatedTvs());
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Popular Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(remoteDataSource.getPopularTvs())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getPopularTvs();

      verify(remoteDataSource.getPopularTvs());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(remoteDataSource.getPopularTvs()).thenThrow(ServerException());

      final result = await repository.getPopularTvs();

      verify(remoteDataSource.getPopularTvs());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(remoteDataSource.getPopularTvs())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getPopularTvs();

      verify(remoteDataSource.getPopularTvs());
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Detail', () {
    const tId = 1;

    test(
        'should return Tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(remoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => testTvModelDetail);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(remoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(remoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(remoteDataSource.getTvDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.getTvDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(remoteDataSource.getTvDetail(tId));
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Episode Detail', () {
    const tId = 1;

    test(
        'should return Tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(remoteDataSource.getTvDetailEpisode(tId, tId, tId))
          .thenAnswer((_) async => testTvEpisodeModel);
      // act
      final result = await repository.getTvDetailEpisode(tId, tId, tId);
      // assert
      verify(remoteDataSource.getTvDetailEpisode(tId, tId, tId));
      expect(result, equals(Right(testTvEpisode)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(remoteDataSource.getTvDetailEpisode(tId, tId, tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvDetailEpisode(tId, tId, tId);
      // assert
      verify(remoteDataSource.getTvDetailEpisode(tId, tId, tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.getTvDetailEpisode(tId, tId, tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetailEpisode(tId, tId, tId);
      // assert
      verify(remoteDataSource.getTvDetailEpisode(tId, tId, tId));
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Season Detail', () {
    const tId = 1;

    test(
        'should return Tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(remoteDataSource.getTvDetailSeason(tId, tId))
          .thenAnswer((_) async => testDetailSeasonModel);
      // act
      final result = await repository.getTvDetailSeason(tId, tId);
      // assert
      verify(remoteDataSource.getTvDetailSeason(tId, tId));
      expect(result, equals(Right(testDetailSeason)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(remoteDataSource.getTvDetailSeason(tId, tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvDetailSeason(tId, tId);
      // assert
      verify(remoteDataSource.getTvDetailSeason(tId, tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(remoteDataSource.getTvDetailSeason(tId, tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetailSeason(tId, tId);
      // assert
      verify(remoteDataSource.getTvDetailSeason(tId, tId));
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Recommendation', () {
    const tId = 1;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(remoteDataSource.getTvsRecommendation(tId))
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getTvsRecommendation(tId);

      verify(remoteDataSource.getTvsRecommendation(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(remoteDataSource.getTvsRecommendation(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvsRecommendation(tId);

      verify(remoteDataSource.getTvsRecommendation(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(remoteDataSource.getTvsRecommendation(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTvsRecommendation(tId);

      verify(remoteDataSource.getTvsRecommendation(tId));
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(localDataSource.insertWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(localDataSource.insertWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(localDataSource.removeWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(localDataSource.removeWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(localDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(localDataSource.getWatchlistTvs())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getTvsWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
