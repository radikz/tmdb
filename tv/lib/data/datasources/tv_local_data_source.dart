import 'package:core/utils/exception.dart';
import 'package:tv/data/models/tv_table.dart';

import 'db/database_helper_tv.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable movie);
  Future<String> removeWatchlist(TvTable movie);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTvs();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelperTv dbHelper;

  TvLocalDataSourceImpl(this.dbHelper);

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await dbHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvs() async {
    final result = await dbHelper.getWatchlistTvs();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvTable movie) async {
    try {
      await dbHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable movie) async {
    try {
      await dbHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
