import 'package:dartz/dartz.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_now_airing_tvs.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowAiringTvs getNowAiringTvs;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getNowAiringTvs = GetNowAiringTvs(repository);
  });
  final listTv = <Tv>[testTv];
  test('get list of tv', () async {
    when(repository.getNowAiringTvs()).thenAnswer((_) async => Right(listTv));

    final result = await getNowAiringTvs.execute();

    expect(result, Right(listTv));
  });
}
