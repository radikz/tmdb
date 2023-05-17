import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/recommendation/recommendation_movie_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(
        FetchRecommendationMovie(1), FetchRecommendationMovie(1));
  });
}
