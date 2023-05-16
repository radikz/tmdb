import 'package:dartz/dartz.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tvs_recommendation.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvsRecommendation getTvsRecommendation;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getTvsRecommendation = GetTvsRecommendation(repository);
  });
  final listTv = <Tv>[testTv];
  test('get list of tv', () async {
    when(repository.getTvsRecommendation(1))
        .thenAnswer((_) async => Right(listTv));

    final result = await getTvsRecommendation.execute(1);

    expect(result, Right(listTv));
  });
}
