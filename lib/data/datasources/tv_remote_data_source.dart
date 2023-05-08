import 'dart:convert';

import 'package:ditonton/data/models/detail_season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_episode_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

import '../../common/exception.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getPopularTvs();
  Future<List<TvModel>> getNowAiringTvs();
  Future<List<TvModel>> getTopRatedTvs();
  Future<TvDetailModel> getTvDetail(int id);
  Future<List<TvModel>> getTvsRecommendation(int id);
  Future<DetailSeasonModel> getTvDetailSeason(int tvId, int seasonNumber);
  Future<TvEpisodeModel> getTvDetailEpisode(
      int tvId, int seasonNumber, int episodeNumber);
  Future<List<TvModel>> searchTvs(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;
  TvRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<TvModel>> getNowAiringTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvEpisodeModel> getTvDetailEpisode(
      int tvId, int seasonNumber, int episodeNumber) async {
    final response = await client.get(Uri.parse(
        '$BASE_URL/tv/$tvId/season/$seasonNumber/episode/$episodeNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return TvEpisodeModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailSeasonModel> getTvDetailSeason(
      int tvId, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$tvId/season/$seasonNumber?$API_KEY'));

    if (response.statusCode == 200) {
      return DetailSeasonModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvsRecommendation(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvs(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
