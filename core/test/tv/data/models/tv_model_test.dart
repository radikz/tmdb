import 'package:core/tv/data/models/tv_model.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tvModel = TvModel(
      firstAirDate: "firstAirDate",
      genreIds: [],
      id: 1,
      name: "name",
      originCountry: [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 9,
      voteAverage: 9,
      voteCount: 10);

  final tvEntity = Tv(
      firstAirDate: "firstAirDate",
      genreIds: [],
      id: 1,
      name: "name",
      originCountry: [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 9,
      voteAverage: 9,
      voteCount: 10);

  test('toEntity', () {
    final entity = tvModel.toEntity();
    expect(entity, isA<Tv>());
  });

  test('toEntity same as tvEntity ', () {
    final entity = tvModel.toEntity();
    expect(entity, tvEntity);
  });
}
