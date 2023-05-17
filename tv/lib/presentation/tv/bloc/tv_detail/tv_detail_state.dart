part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetail result;

  const TvDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TvDetailFailure extends TvDetailState {
  final String message;

  const TvDetailFailure(this.message);
}
