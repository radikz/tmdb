import 'dart:io';

import 'package:core/movie/data/models/movie_model.dart';
import 'package:core/search/data/datasources/search_remote_datasource.dart';
import 'package:core/search/data/repositories/search_repository_impl.dart';
import 'package:core/tv/data/models/tv_model.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_repository_impl_test.mocks.dart';

@GenerateMocks([SearchRemoteDataSource])
void main() {
  late SearchRepositoryImpl repository;
  late MockSearchRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockSearchRemoteDataSource();
    repository = SearchRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testTv = Tv(
      firstAirDate: DateTime(2023, 2, 2).toIso8601String(),
      genreIds: const [],
      id: 1,
      name: "name",
      originCountry: const [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 9,
      voteAverage: 9,
      voteCount: 9);

  final testTvModel = TvModel(
      firstAirDate: DateTime(2023, 2, 2).toIso8601String(),
      genreIds: const [],
      id: 1,
      name: "name",
      originCountry: const [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 9,
      voteAverage: 9,
      voteCount: 9);

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];
  final tTvModelList = <TvModel>[testTvModel];
  final tTvList = <Tv>[testTv];

  group('Seach Movies', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchMovies(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Search TV', () {
    const keyword = "test";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.searchTvs(keyword))
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.searchTvs(keyword);

      verify(mockRemoteDataSource.searchTvs(keyword));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchTvs(keyword))
          .thenThrow(ServerException());

      final result = await repository.searchTvs(keyword);

      verify(mockRemoteDataSource.searchTvs(keyword));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.searchTvs(keyword))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.searchTvs(keyword);

      verify(mockRemoteDataSource.searchTvs(keyword));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
