import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final genreModel = GenreModel(id: 28, name: "Action");

  final genreEntity = Genre(id: 28, name: "Action");

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
