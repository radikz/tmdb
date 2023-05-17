import 'package:bloc_test/bloc_test.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movie_bloc.dart';

import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGettopRatedMovies;

  setUp(() {
    mockGettopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGettopRatedMovies);
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
    expect(topRatedMovieBloc.state, TopRatedMovieInitial());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGettopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovie()),
    expect: () => <TopRatedMovieState>[
      TopRatedMovieLoading(),
      TopRatedMovieLoaded(tMovieList),
    ],
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGettopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure("Error")));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovie()),
    expect: () => <TopRatedMovieState>[
      TopRatedMovieLoading(),
      const TopRatedMovieFailure("Error"),
    ],
  );
}
