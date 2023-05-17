import 'package:bloc_test/bloc_test.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/popular/popular_movie_bloc.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetpopularMovies;

  setUp(() {
    mockGetpopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetpopularMovies);
  });

  const tMovie = Movie(
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
    expect(popularMovieBloc.state, PopularMovieInitial());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetpopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    expect: () => <PopularMovieState>[
      PopularMovieLoading(),
      PopularMovieLoaded(tMovieList),
    ],
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetpopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure("Error")));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    expect: () => <PopularMovieState>[
      PopularMovieLoading(),
      const PopularMovieFailure("Error"),
    ],
  );
}
