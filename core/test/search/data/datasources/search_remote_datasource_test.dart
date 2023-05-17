import 'dart:convert';

import 'package:core/movie/data/models/movie_response.dart';
import 'package:core/search/data/datasources/search_remote_datasource.dart';
import 'package:core/tv/data/models/tv_response.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/json_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_remote_datasource_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<IOClient>(as: #MockHttpClient)])
void main() {
  late SearchRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SearchRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    const tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_spiderman_movie.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get search tv', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/dummy_tv_list.json')))
        .tvList;

    test('return list tv model when response 200', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=test')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 200));

      final result = await dataSource.searchTvs("test");

      expect(result, equals(tvList));
    });

    test('throw server exception when response 404', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=test')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 404));

      final call = dataSource.searchTvs("test");

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
