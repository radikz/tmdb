import 'package:tv/data/datasources/db/database_helper_tv.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  DatabaseHelperTv,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
