import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_now_airing_tvs.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/top_rated/top_rated_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTvs);
  });

  final tTvList = <Tv>[testTv];

  test('initial state is initial', () {
    expect(topRatedTvBloc.state, TopRatedTvInitial());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    expect: () => <TopRatedTvState>[
      TopRatedTvLoading(),
      TopRatedTvLoaded(tTvList),
    ],
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetTopRatedTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure("Error")));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    expect: () => <TopRatedTvState>[
      TopRatedTvLoading(),
      TopRatedTvFailure("Error"),
    ],
  );
}
