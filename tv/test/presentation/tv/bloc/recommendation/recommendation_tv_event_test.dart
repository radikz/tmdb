import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/tv/bloc/recommendation/recommendation_tv_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(const FetchRecommendationTv(1), const FetchRecommendationTv(1));
  });
}