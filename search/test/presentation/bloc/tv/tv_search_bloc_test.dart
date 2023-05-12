import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/bloc/tv/tv_search_bloc.dart';

import 'tv_search_bloc_test.mocks.dart';


@GenerateMocks([SearchTvs])
void main() {
  late TvSearchBloc searchBloc;
  late MockSearchTvs mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTvs();
    searchBloc = TvSearchBloc(mockSearchTv);
  });

  final tTv = Tv(
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
final tTvList = <Tv>[tTv];
final tQuery = 'spiderman';

  test('initial state should be initial', () {
  expect(searchBloc.state, TvSearchInitial());
});

blocTest<TvSearchBloc, TvSearchState>(
  'Should emit [Loading, HasData] when data is gotten successfully',
  build: () {
    when(mockSearchTv.execute(tQuery))
        .thenAnswer((_) async => Right(tTvList));
    return searchBloc;
  },
  act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    TvSearchLoading(),
    TvSearchHasData(tTvList),
  ],
  verify: (bloc) {
    verify(mockSearchTv.execute(tQuery));
  },
);

blocTest<TvSearchBloc, TvSearchState>(
  'Should emit [Loading, Error] when get search is unsuccessful',
  build: () {
    when(mockSearchTv.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    return searchBloc;
  },
  act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
  expect: () => [
    TvSearchLoading(),
    TvSearchError('Server Failure'),
  ],
  wait: Duration(milliseconds: 500),
  verify: (bloc) {
    verify(mockSearchTv.execute(tQuery));
  },
);


}
