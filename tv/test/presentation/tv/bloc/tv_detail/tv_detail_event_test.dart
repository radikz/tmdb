import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/tv/bloc/tv_detail/tv_detail_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchTvDetail(1), FetchTvDetail(1));
  });
}