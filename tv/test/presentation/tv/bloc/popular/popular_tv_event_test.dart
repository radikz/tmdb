import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/tv/bloc/popular/popular_tv_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchPopularTv(), FetchPopularTv());
  });
}