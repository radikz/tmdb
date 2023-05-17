import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  const Tv({
    this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  const Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  })  : backdropPath = null,
        firstAirDate = null,
        genreIds = null,
        originCountry = null,
        originalLanguage = null,
        originalName = null,
        popularity = null,
        voteAverage = null,
        voteCount = null;

  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
