import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetailSeason getTvDetailSeason;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getTvDetailSeason = GetTvDetailSeason(repository);
  });

  test('get detail season', () async {
    when(repository.getTvDetailSeason(1, 1)).thenAnswer((_) async => Right(testDetailSeason));

    final result = await getTvDetailSeason.execute(1, 1);

    expect(result, Right(testDetailSeason));
  });
}
