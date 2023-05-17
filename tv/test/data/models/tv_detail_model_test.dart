import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_episode_model.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_episode.dart';

void main() {
  final detailTvModel = TvDetailModel(
      backdropPath: "backdrop",
      episodeRunTime: const [90],
      firstAirDate: DateTime(2023, 4, 4),
      genres: const [],
      homepage: "homepage",
      id: 1,
      inProduction: true,
      languages: const [],
      lastAirDate: DateTime(2023),
      lastEpisodeToAir: TvEpisodeModel(
          id: 1,
          name: "name",
          overview: "overview",
          voteAverage: 9,
          voteCount: 9,
          airDate: DateTime(2023),
          episodeNumber: 9,
          productionCode: "productionCode",
          seasonNumber: 9,
          stillPath: "stillPath"),
      name: "name",
      numberOfEpisodes: 9,
      numberOfSeasons: 9,
      originCountry: const [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 9,
      posterPath: "posterPath",
      seasons: [
        SeasonModel(
          airDate: DateTime(2023),
          episodeCount: 3,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 9,
        ),
      ],
      status: "status",
      tagline: "tagline",
      type: "type",
      voteAverage: 9,
      voteCount: 9);

  final detailTv = TvDetail(
      backdropPath: "backdrop",
      episodeRunTime: const [90],
      firstAirDate: DateTime(2023, 4, 4),
      genres: const [],
      homepage: "homepage",
      id: 1,
      inProduction: true,
      languages: const [],
      lastAirDate: DateTime(2023),
      lastEpisodeToAir: TvEpisode(
          id: 1,
          name: "name",
          overview: "overview",
          voteAverage: 9,
          voteCount: 9,
          airDate: DateTime(2023),
          episodeNumber: 9,
          productionCode: "productionCode",
          seasonNumber: 9,
          stillPath: "stillPath"),
      name: "name",
      numberOfEpisodes: 9,
      numberOfSeasons: 9,
      originCountry: const [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 9,
      posterPath: "posterPath",
      seasons: [
        Season(
          airDate: DateTime(2023),
          episodeCount: 3,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 9,
        ),
      ],
      status: "status",
      tagline: "tagline",
      type: "type",
      voteAverage: 9,
      voteCount: 9);

  test('to entity', () {
    final entity = detailTvModel.toEntity();

    expect(entity, equals(detailTv));
  });
}
