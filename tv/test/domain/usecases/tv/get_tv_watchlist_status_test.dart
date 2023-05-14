
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_watchlist_status.dart';

import '../../../helpers/test_helper.mocks.dart';


void main() {
  late GetTvWatchlistStatus getTvWatchlistStatus;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getTvWatchlistStatus = GetTvWatchlistStatus(repository);
  });

  test('get tv watchlist status', () async {
    when(repository.isAddedToWatchlist(1)).thenAnswer((_) async => true);

    final result = await getTvWatchlistStatus.execute(1);

    expect(result, true);
  });
}
