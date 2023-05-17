import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_popular_tvs.dart';
import 'package:tv/presentation/tv/bloc/popular/popular_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvBloc = PopularTvBloc(mockGetPopularTvs);
  });

  final tTvList = <Tv>[testTv];

  test('initial state is initial', () {
    expect(popularTvBloc.state, PopularTvInitial());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    expect: () => <PopularTvState>[
      PopularTvLoading(),
      PopularTvLoaded(tTvList),
    ],
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => const Left(ServerFailure("Error")));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    expect: () => <PopularTvState>[
      PopularTvLoading(),
      const PopularTvFailure("Error"),
    ],
  );
}