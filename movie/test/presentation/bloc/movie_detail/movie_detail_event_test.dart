import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(const FetchMovieDetail(1), const FetchMovieDetail(1));
  });
}
