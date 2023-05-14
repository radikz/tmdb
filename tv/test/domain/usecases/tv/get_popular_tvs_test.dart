import 'package:dartz/dartz.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_popular_tvs.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvs getPopularTvs;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getPopularTvs = new GetPopularTvs(repository);
  });
  final listTv = <Tv>[testTv];
  test('get list of tv', () async {
    when(repository.getPopularTvs()).thenAnswer((_) async => Right(listTv));

    final result = await getPopularTvs.execute();

    expect(result, Right(listTv));
  });
}
