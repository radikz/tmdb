import 'package:bloc/bloc.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieInitial()) {
    on<FetchTopRatedMovie>((event, emit) async {
      emit(TopRatedMovieLoading());

      final result = await _getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(TopRatedMovieFailure(failure.message));
        },
        (moviesData) {
          emit(TopRatedMovieLoaded(moviesData));
        },
      );
    });
  }

  final GetTopRatedMovies _getTopRatedMovies;
}
