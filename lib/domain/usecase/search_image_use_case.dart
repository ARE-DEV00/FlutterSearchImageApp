import 'package:get_it/get_it.dart';
import 'package:search_image/data/local/db/repository/data_base_repository_impl.dart';
import 'package:search_image/data/remote/api/repository/api_repository_impl.dart';
import 'package:search_image/domain/entity/search_image_result_entity.dart';
import 'package:search_image/domain/enums/sort_type.dart';

import 'package:search_image/domain/repository/api_repository.dart';
import 'package:search_image/domain/repository/data_base_repository.dart';

class SearchImageUseCase {
  final ApiRepository _apiRepository = GetIt.instance<ApiRepositoryImpl>();
  final DataBaseRepository _dataBaseRepository = GetIt.instance<DataBaseRepositoryImpl>();

  Future<SearchImageResultEntity> getSearchImageList(String query, int page) async {
    final searchResult = await _apiRepository.getSearchImageList(query, SortType.accuracy.name, page, 30);

    /// 이미지가 즐겨찾기에 추가되어 있는지 확인
    for (var imageInfoEntity in searchResult.imageInfoEntityList) {
      final isFavorite = await _dataBaseRepository.isExistFavoriteImage(imageInfoEntity);
      imageInfoEntity.isFavorite = isFavorite;
    }

    return searchResult;
  }
}
