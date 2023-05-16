import 'dart:convert';

import 'package:core/tv/data/models/tv_model.dart';
import 'package:core/tv/data/models/tv_response.dart';
import 'package:core/utils/json_reader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvModel = TvModel(
    backdropPath: "/xgZ9AhvXqi9aSDWzCpoC9JAkLPY.jpg",
    firstAirDate: "2019-01-01",
    genreIds: [35],
    id: 85425,
    name: "Dear Heirs",
    originCountry: ["HU"],
    originalLanguage: "hu",
    originalName: "Drága örökösök",
    overview:
        "Hungarian remake of the Bulgarian series about a disconnect family living together in order to get an inheritance.",
    popularity: 1948.879,
    posterPath: "/xDOUahrwEsgDlejXjZLc9lOljSx.jpg",
    voteAverage: 5.3,
    voteCount: 7,
  );

  late TvResponse tvResponse;

  setUp(() {
    tvResponse = TvResponse([tvModel]);
  });

  group('fromJson', () {
    test('return valid JSON', () async {
      final Map<String, dynamic> map =
          json.decode(readJson('dummy_data/dummy_tv_list.json'));

      final result = TvResponse.fromJson(map);

      expect(result, tvResponse);
    });
  });

  group('toJson', () {
    test('return json map', () {
      final result = tvResponse.toJson();

      final expected = {
        "results": [
          {
            "backdrop_path": "/xgZ9AhvXqi9aSDWzCpoC9JAkLPY.jpg",
            "first_air_date": "2019-01-01",
            "genre_ids": [35],
            "id": 85425,
            "name": "Dear Heirs",
            "origin_country": ["HU"],
            "original_language": "hu",
            "original_name": "Drága örökösök",
            "overview":
                "Hungarian remake of the Bulgarian series about a disconnect family living together in order to get an inheritance.",
            "popularity": 1948.879,
            "poster_path": "/xDOUahrwEsgDlejXjZLc9lOljSx.jpg",
            "vote_average": 5.3,
            "vote_count": 7
          }
        ]
      };

      expect(result, expected);
    });
  });
}
