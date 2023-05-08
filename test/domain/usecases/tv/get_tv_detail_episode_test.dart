import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_episode.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetailEpisode getTvDetailEpisode;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getTvDetailEpisode = GetTvDetailEpisode(repository);
  });

  test('get tv episode', () async {
    when(repository.getTvDetailEpisode(1, 1, 1)).thenAnswer((_) async => Right(testTvEpisode));

    final result = await getTvDetailEpisode.execute(1, 1, 1);

    expect(result, Right(testTvEpisode));
  });
}
