import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/now_playing/bloc/now_playing_movie_bloc.dart';

import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('initial state is initial', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMovieInitial());
  });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovie()),
    expect: () => <NowPlayingMovieState>[
      NowPlayingMovieLoading(),
      NowPlayingMovieLoaded(tMovieList),
    ],
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("Error")));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovie()),
    expect: () => <NowPlayingMovieState>[
      NowPlayingMovieLoading(),
      NowPlayingMovieFailure("Error"),
    ],
  );
}
