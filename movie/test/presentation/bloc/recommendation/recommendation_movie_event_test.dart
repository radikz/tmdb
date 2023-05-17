import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/recommendation/recommendation_movie_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(const FetchRecommendationMovie(1), const FetchRecommendationMovie(1));
  });
}
