import 'package:findmitter_frontend/data/repository/api_data_repository.dart';
import 'package:findmitter_frontend/domain/repository/api_repository.dart';
import 'package:findmitter_frontend/internal/dependencies/api_module.dart';

class RepositoryModule {
  static ApiRepository? _apiRepository;
  static ApiRepository apiRepository() {
    return _apiRepository ??
        ApiDataRepository(
          ApiModule.auth(),
          ApiModule.api(),
        );
  }
}
