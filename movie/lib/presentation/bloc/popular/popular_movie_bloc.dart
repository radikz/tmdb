import 'package:bloc/bloc.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieInitial()) {
    on<FetchPopularMovie>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(PopularMovieFailure(failure.message));
        },
        (moviesData) {
          emit(PopularMovieLoaded(moviesData));
        },
      );
    });
  }

  final GetPopularMovies _getPopularMovies;
}
