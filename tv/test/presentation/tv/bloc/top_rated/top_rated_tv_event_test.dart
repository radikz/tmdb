import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/tv/bloc/top_rated/top_rated_tv_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchTopRatedTv(), FetchTopRatedTv());
  });
}
