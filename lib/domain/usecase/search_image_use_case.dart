import 'package:get_it/get_it.dart';
import 'package:search_image/data/remote/api/repository/api_repository_impl.dart';
import 'package:search_image/domain/entity/search_image_result_entity.dart';
import 'package:search_image/domain/enums/SortType.dart';

import 'package:search_image/domain/repository/api_repository.dart';

class SearchImageUseCase {
  final ApiRepository _apiRepository = GetIt.instance<ApiRepositoryImpl>();

  Future<SearchImageResultEntity> getSearchImageList(String query, int page) async {
    return await _apiRepository.getSearchImageList(query, SortType.accuracy.name, page, 30);
  }
}
