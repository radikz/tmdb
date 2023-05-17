import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_episode.dart';
import 'package:tv/presentation/tv/bloc/episode_detail/episode_detail_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'episode_detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetailEpisode])
void main() {
  late EpisodeDetailTvBloc episodeDetailTvBloc;
  late MockGetTvDetailEpisode mockGetEpisodeDetailTvs;

  setUp(() {
    mockGetEpisodeDetailTvs = MockGetTvDetailEpisode();
    episodeDetailTvBloc = EpisodeDetailTvBloc(mockGetEpisodeDetailTvs);
  });

  final tTvList = <Tv>[testTv];

  test('initial state is initial', () {
    expect(episodeDetailTvBloc.state, EpisodeDetailTvInitial());
  });

  blocTest<EpisodeDetailTvBloc, EpisodeDetailTvState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetEpisodeDetailTvs.execute(1, 1, 1))
          .thenAnswer((_) async => Right(testTvEpisode));
      return episodeDetailTvBloc;
    },
    act: (bloc) => bloc.add(
        const FetchEpisodeDetailTv(id: 1, seasonNumber: 1, episodeNumber: 1)),
    expect: () => <EpisodeDetailTvState>[
      EpisodeDetailTvLoading(),
      EpisodeDetailTvLoaded(testTvEpisode),
    ],
  );

  blocTest<EpisodeDetailTvBloc, EpisodeDetailTvState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetEpisodeDetailTvs.execute(1, 1, 1))
          .thenAnswer((_) async => const Left(ServerFailure("Error")));
      return episodeDetailTvBloc;
    },
    act: (bloc) => bloc.add(
        const FetchEpisodeDetailTv(id: 1, seasonNumber: 1, episodeNumber: 1)),
    expect: () => <EpisodeDetailTvState>[
      EpisodeDetailTvLoading(),
      const EpisodeDetailTvFailure("Error"),
    ],
  );
}
