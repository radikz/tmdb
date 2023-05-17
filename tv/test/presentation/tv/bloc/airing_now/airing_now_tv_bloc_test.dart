import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_now_airing_tvs.dart';
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'airing_now_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowAiringTvs])
void main() {
  late AiringNowTvBloc airingNowTvBloc;
  late MockGetNowAiringTvs mockGetAiringNowTvs;

  setUp(() {
    mockGetAiringNowTvs = MockGetNowAiringTvs();
    airingNowTvBloc = AiringNowTvBloc(mockGetAiringNowTvs);
  });

  final tTvList = <Tv>[testTv];

  test('initial state is initial', () {
    expect(airingNowTvBloc.state, AiringNowTvInitial());
  });

  blocTest<AiringNowTvBloc, AiringNowTvState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetAiringNowTvs.execute())
          .thenAnswer((_) async => Right(tTvList));
      return airingNowTvBloc;
    },
    act: (bloc) => bloc.add(FetchAiringNowTv()),
    expect: () => <AiringNowTvState>[
      AiringNowTvLoading(),
      AiringNowTvLoaded(tTvList),
    ],
  );

  blocTest<AiringNowTvBloc, AiringNowTvState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetAiringNowTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure("Error")));
      return airingNowTvBloc;
    },
    act: (bloc) => bloc.add(FetchAiringNowTv()),
    expect: () => <AiringNowTvState>[
      AiringNowTvLoading(),
      AiringNowTvFailure("Error"),
    ],
  );
}
