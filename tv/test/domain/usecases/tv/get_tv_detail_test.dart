import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late GetTvDetail getTvDetail;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getTvDetail = GetTvDetail(repository);
  });

  test('get detail of tv', () async {
    when(repository.getTvDetail(1))
        .thenAnswer((_) async => Right(testTvDetail));

    final result = await getTvDetail.execute(1);

    expect(result, Right(testTvDetail));
  });
}
