import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:tv/presentation/tv/bloc/season_detail/season_detail_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'season_detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetailSeason])
void main() {
  late SeasonDetailTvBloc episodeDetailTvBloc;
  late MockGetTvDetailSeason mockGetSeasonDetailTvs;

  setUp(() {
    mockGetSeasonDetailTvs = MockGetTvDetailSeason();
    episodeDetailTvBloc = SeasonDetailTvBloc(mockGetSeasonDetailTvs);
  });

  final tTvList = <Tv>[testTv];

  test('initial state is initial', () {
    expect(episodeDetailTvBloc.state, SeasonDetailTvInitial());
  });

  blocTest<SeasonDetailTvBloc, SeasonDetailTvState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetSeasonDetailTvs.execute(
        1,
        1,
      )).thenAnswer((_) async => Right(testDetailSeason));
      return episodeDetailTvBloc;
    },
    act: (bloc) => bloc.add(const FetchSeasonDetailTv(
      id: 1,
      seasonNumber: 1,
    )),
    expect: () => <SeasonDetailTvState>[
      SeasonDetailTvLoading(),
      SeasonDetailTvLoaded(testDetailSeason),
    ],
  );

  blocTest<SeasonDetailTvBloc, SeasonDetailTvState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetSeasonDetailTvs.execute(
        1,
        1,
      )).thenAnswer((_) async => const Left(ServerFailure("Error")));
      return episodeDetailTvBloc;
    },
    act: (bloc) => bloc.add(const FetchSeasonDetailTv(
      id: 1,
      seasonNumber: 1,
    )),
    expect: () => <SeasonDetailTvState>[
      SeasonDetailTvLoading(),
      const SeasonDetailTvFailure("Error"),
    ],
  );
}
