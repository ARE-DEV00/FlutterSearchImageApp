import 'package:get_it/get_it.dart';
import 'package:search_image/data/remote/api/repository/api_repository_impl.dart';
import 'package:search_image/domain/entity/sample_entity.dart';

import 'package:search_image/domain/repository/api_repository.dart';

class SampleUseCase {
  final ApiRepository _apiRepository = GetIt.instance<ApiRepositoryImpl>();

  Future<SampleEntity?> createSample(String description) async {
    return await _apiRepository.createSample(description);
  }
}
