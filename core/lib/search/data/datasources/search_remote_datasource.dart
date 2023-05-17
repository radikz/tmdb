import 'dart:convert';

import 'package:core/movie/data/models/movie_model.dart';
import 'package:core/movie/data/models/movie_response.dart';
import 'package:core/tv/data/models/tv_model.dart';
import 'package:core/tv/data/models/tv_response.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:http/io_client.dart';

abstract class SearchRemoteDataSource {
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<TvModel>> searchTvs(String query);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final IOClient client;

  SearchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
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
