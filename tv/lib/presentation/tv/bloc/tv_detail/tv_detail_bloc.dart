import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  TvDetailBloc(this._getTvDetail) : super(TvDetailInitial()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());
      final id = event.id;
      final result = await _getTvDetail.execute(id);

      result.fold((failure) {
        emit(TvDetailFailure(failure.message));
      }, (movie) {
        emit(TvDetailLoaded(movie));
      });
    });
  }

  final GetTvDetail _getTvDetail;
}
