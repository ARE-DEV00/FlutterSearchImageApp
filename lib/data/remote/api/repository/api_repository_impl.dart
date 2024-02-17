import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:search_image/data/remote/api/api_service.dart';
import 'package:search_image/domain/entity/image_info_entitiy.dart';
import 'package:search_image/domain/entity/search_image_result_entity.dart';
import 'package:search_image/domain/entity/search_image_list_meta_entity.dart';
import 'package:search_image/domain/repository/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiService _apiService = GetIt.instance<ApiService>();

  @override
  Future<SearchImageResultEntity> getSearchImageList(
      String query, String? sort, int? page, int? size) async {
    try {
      // API 호출 및 응답 대기
      final response =
          await _apiService.getSearchImageList(query, sort, page, size);

      if (response != null) {
        log("[KSH]response - OK");
        final searchImageResultMetaEntity = SearchImageResultMetaEntity(
          isEnd: response.meta.isEnd,
          pageableCount: response.meta.pageableCount,
          totalCount: response.meta.totalCount,
        );

        if (response.documents.isEmpty) {
          return SearchImageResultEntity(searchImageResultMetaEntity: searchImageResultMetaEntity, imageInfoEntityList: []);
        } else {
          List<ImageInfoEntity> imageInfoEntityList = response.documents.map((value) {
             return ImageInfoEntity(
              imageUrl: value.imageUrl,
              collection: value.collection,
              datetime: value.datetime,
              docUrl: value.docUrl,
              height: value.height,
              thumbnailUrl: value.thumbnailUrl,
              width: value.width,
              displaySitename: value.displaySitename,
            );
          }).toList();

          return SearchImageResultEntity(
            searchImageResultMetaEntity: searchImageResultMetaEntity,
            imageInfoEntityList: imageInfoEntityList,
          );
        }
      } else {
        // API 호출은 성공했지만 응답이 오지 않은 경우
        log("[KSH]response - Fail");
        return SearchImageResultEntity(imageInfoEntityList: []);
      }
    } catch (e) {
      // API 호출 중 에러가 발생한 경우
      log("[KSH]response - ERROR");
      return SearchImageResultEntity(imageInfoEntityList: []);
    }
  }
}
