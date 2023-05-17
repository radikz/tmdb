import 'package:core/movie/data/models/genre_model.dart';
import 'package:core/movie/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const genreModel = GenreModel(id: 28, name: "Action");

  const genreEntity = Genre(id: 28, name: "Action");

  test('toEntity', () {
    final entity = genreModel.toEntity();
    expect(entity, isA<Genre>());
  });

  test('toEntity same as tvEntity ', () {
    final entity = genreModel.toEntity();
    expect(entity, genreEntity);
  });

  test('toJson', () {
    final result = genreModel.toJson();
    final expected = {"id": 28, "name": "Action"};
    expect(result, expected);
  });
}
