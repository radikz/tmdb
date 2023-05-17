import 'dart:convert';

import 'package:core/movie/data/models/genre_model.dart';
import 'package:core/utils/json_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_model.dart';

void main() {
  test('toJson should return a valid JSON object', () {
    const movieDetail = MovieDetailResponse(
      adult: false,
      backdropPath: "/path.jpg",
      budget: 100,
      genres: [
        GenreModel(id: 1, name: "Action"),
      ],
      homepage: "https://google.com",
      id: 1,
      imdbId: "imdb1",
      originalLanguage: "en",
      originalTitle: "Original Title",
      overview: "Overview",
      popularity: 1.0,
      posterPath: "/path.jpg",
      releaseDate: "2020-05-05",
      revenue: 12000,
      runtime: 120,
      status: "Status",
      tagline: "Tagline",
      title: "Title",
      video: false,
      voteAverage: 1.0,
      voteCount: 1,
    );

    final jsonResult = movieDetail.toJson();
    expect(jsonResult, json.decode(readJson('dummy_data/movie_detail.json')));
  });
}
