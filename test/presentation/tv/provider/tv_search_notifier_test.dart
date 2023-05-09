import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:ditonton/presentation/tv/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late MockSearchTvs mockSearchTvs;
  late TvSearchNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    notifier = TvSearchNotifier(mockSearchTvs)
      ..addListener(() {
        listenerCallCount++;
      });
    listenerCallCount = 0;
  });

  final testListTv = <Tv>[testTv];

  test('loading data', () {
    when(mockSearchTvs.execute("test"))
        .thenAnswer((_) async => Right(testListTv));

    notifier.search("test");

    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('data loaded', () async {
    when(mockSearchTvs.execute("test"))
        .thenAnswer((_) async => Right(testListTv));

    await notifier.search("test");

    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, testListTv);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockSearchTvs.execute("test"))
        .thenAnswer((_) async => Left(ServerFailure("Server Failure")));

    await notifier.search("test");

    expect(notifier.state, RequestState.Error);
    expect(notifier.message, "Server Failure");
    expect(listenerCallCount, 2);
  });
}
