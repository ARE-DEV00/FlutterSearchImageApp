import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:search_image/data/model/sample_request.dart';
import 'package:search_image/data/remote/api/api_service.dart';
import 'package:search_image/domain/entity/search_image_entity.dart';
import 'package:search_image/domain/repository/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiService _apiService = GetIt.instance<ApiService>();

  @override
  Future<List<SearchImageEntity>> getSearchImageList(String query, String? sort, int? page, int? size) async {
    try {
      // API 호출 및 응답 대기
      final response =
          await _apiService.getSearchImageList(query, sort, page, size);

      // 성공적인 응답인 경우
      if (response != null) {
        log("[KSH]response - OK");

        if (response.documents.isEmpty) {
          return [];
        } else {
          return response.documents.map((value) {
            log("[KSH] Result: ${value.displaySitename}: ${value.imageUrl}");
            return SearchImageEntity(value.displaySitename, value.imageUrl);
          }).toList();
        }
      } else {
        // API 호출은 성공했지만 응답이 예상대로 오지 않은 경우
        log("[KSH]response - Fail");
        return [];
      }
    } catch (e) {
      // API 호출 중 에러가 발생한 경우
      log("[KSH]response - ERROR");
      return [];
    }
  }
}
