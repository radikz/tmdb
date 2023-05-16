import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailInitial()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      final id = event.id;
      final result = await _getMovieDetail.execute(id);

      result.fold((failure) {
        emit(MovieDetailFailure(failure.message));
      }, (movie) {
        emit(MovieDetailLoaded(movie));
      });
    });
  }

  final GetMovieDetail _getMovieDetail;
}
