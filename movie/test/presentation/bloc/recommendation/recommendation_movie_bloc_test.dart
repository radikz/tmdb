import 'package:bloc_test/bloc_test.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/recommendation/recommendation_movie_bloc.dart';

import 'recommendation_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMovieBloc recommendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendations);
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
    expect(recommendationMovieBloc.state, RecommendationMovieInitial());
  });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(tMovieList));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationMovie(1)),
    expect: () => <RecommendationMovieState>[
      RecommendationMovieLoading(),
      RecommendationMovieLoaded(tMovieList),
    ],
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'emits [Loading, Empty] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(<Movie>[]));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationMovie(1)),
    expect: () => <RecommendationMovieState>[
      RecommendationMovieLoading(),
      RecommendationMovieEmpty(),
    ],
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Error")));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationMovie(1)),
    expect: () => <RecommendationMovieState>[
      RecommendationMovieLoading(),
      RecommendationMovieFailure("Error"),
    ],
  );
}
