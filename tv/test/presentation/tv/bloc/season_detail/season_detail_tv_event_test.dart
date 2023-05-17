import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/tv/bloc/season_detail/season_detail_tv_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchSeasonDetailTv(id: 1, seasonNumber: 1,), FetchSeasonDetailTv(id: 1, seasonNumber: 1, ));
  });
}