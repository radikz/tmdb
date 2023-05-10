import 'package:dartz/dartz.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvs getTopRatedTvs;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getTopRatedTvs = new GetTopRatedTvs(repository);
  });
  final listTv = <Tv>[testTv];
  test('get list of tv', () async {
    when(repository.getTopRatedTvs()).thenAnswer((_) async => Right(listTv));

    final result = await getTopRatedTvs.execute();

    expect(result, Right(listTv));
  });
}
