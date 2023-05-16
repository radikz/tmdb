import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';

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

  final testTv = Tv(
      firstAirDate: DateTime(2023, 2, 2).toIso8601String(),
      genreIds: [],
      id: 1,
      name: "name",
      originCountry: [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 9,
      voteAverage: 9,
      voteCount: 9);

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
