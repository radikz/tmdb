import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movie_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchTopRatedMovie(), FetchTopRatedMovie());
  });
}
