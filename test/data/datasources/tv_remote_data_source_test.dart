import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/detail_season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_episode_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl source;
  late MockHttpClient client;

  setUp(() {
    client = MockHttpClient();
    source = TvRemoteDataSourceImpl(client: client);
  });

  group('get airing today tv', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/dummy_tv_list.json')))
        .tvList;

    test('return list tv model when response 200', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 200));

      final result = await source.getNowAiringTvs();

      expect(result, equals(tvList));
    });

    test('throw server exception when response 404', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 404));

      final call = source.getNowAiringTvs();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular tv', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/dummy_tv_list.json')))
        .tvList;

    test('return list tv model when response 200', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer(
          (_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 200));

      final result = await source.getPopularTvs();

      expect(result, equals(tvList));
    });

    test('throw server exception when response 404', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer(
          (_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 404));

      final call = source.getPopularTvs();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tv', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/dummy_tv_list.json')))
        .tvList;

    test('return list tv model when response 200', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer(
          (_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 200));

      final result = await source.getTopRatedTvs();

      expect(result, equals(tvList));
    });

    test('throw server exception when response 404', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer(
          (_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 404));

      final call = source.getTopRatedTvs();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get detail tv', () {
    final detailSeason = TvDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('return detail tv model when response 200', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/1?$API_KEY'))).thenAnswer(
          (_) async =>
              http.Response(readJson("dummy_data/tv_detail.json"), 200));

      final result = await source.getTvDetail(1);

      expect(result, equals(detailSeason));
    });

    test('throw server exception when response 404', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/1?$API_KEY'))).thenAnswer(
          (_) async =>
              http.Response(readJson("dummy_data/tv_detail.json"), 404));

      final call = source.getTvDetail(1);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get detail tv season', () {
    final detailSeason = DetailSeasonModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail_season.json')));

    test('return detail season model when response 200', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/1/season/1?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/tv_detail_season.json"), 200));

      final result = await source.getTvDetailSeason(1, 1);

      expect(result, equals(detailSeason));
    });

    test('throw server exception when response 404', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/1/season/1?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/tv_detail_season.json"), 404));

      final call = source.getTvDetailSeason(1, 1);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get detail tv episode', () {
    final detailSeason = TvEpisodeModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail_episode.json')));

    test('return episode model when response 200', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/1/season/1/episode/1?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson("dummy_data/tv_detail_episode.json"), 200));

      final result = await source.getTvDetailEpisode(1, 1, 1);

      expect(result, equals(detailSeason));
    });

    test('throw server exception when response 404', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/1/season/1/episode/1?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson("dummy_data/tv_detail_episode.json"), 404));

      final call = source.getTvDetailEpisode(1, 1, 1);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get recommendation tv', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/dummy_tv_list.json')))
        .tvList;

    test('return list tv model when response 200', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/1/recommendations?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 200));

      final result = await source.getTvsRecommendation(1);

      expect(result, equals(tvList));
    });

    test('throw server exception when response 404', () async {
      when(client.get(Uri.parse('$BASE_URL/tv/1/recommendations?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 404));

      final call = source.getTvsRecommendation(1);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get search tv', () {
    final tvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/dummy_tv_list.json')))
        .tvList;

    test('return list tv model when response 200', () async {
      when(client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=test')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 200));

      final result = await source.searchTvs("test");

      expect(result, equals(tvList));
    });

    test('throw server exception when response 404', () async {
      when(client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=test')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/dummy_tv_list.json"), 404));

      final call = source.searchTvs("test");

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
