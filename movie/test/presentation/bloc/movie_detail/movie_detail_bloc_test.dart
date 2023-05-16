import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../../helper/dummy.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetails;

  setUp(() {
    mockGetMovieDetails = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetails);
  });

  test('initial state is initial', () {
    expect(movieDetailBloc.state, MovieDetailInitial());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetails.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(1)),
    expect: () => <MovieDetailState>[
      MovieDetailLoading(),
      MovieDetailLoaded(testMovieDetail),
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetMovieDetails.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Error")));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(FetchMovieDetail(1)),
    expect: () => <MovieDetailState>[
      MovieDetailLoading(),
      MovieDetailFailure("Error"),
    ],
  );
}
