import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/popular/popular_movie_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchPopularMovie(), FetchPopularMovie());
  });
}
