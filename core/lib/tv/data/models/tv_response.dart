import 'package:equatable/equatable.dart';

import 'package:core/tv/data/models/tv_model.dart';

class TvResponse extends Equatable {
  final List<TvModel> tvList;

  TvResponse(this.tvList);

  @override
  List<Object> get props => [tvList];

  factory TvResponse.fromJson(Map<String, dynamic> map) {
    return TvResponse(
      List<TvModel>.from((map['results'] as List)
          .map((x) => TvModel.fromJson(x))
          .where((element) => element.posterPath != null)),
    );
  }

  Map<String, dynamic> toJson() =>
      {"results": List<dynamic>.from(tvList.map((e) => e.toJson()))};
}
