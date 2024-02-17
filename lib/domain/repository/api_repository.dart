import 'package:search_image/domain/entity/search_image_result_entity.dart';

abstract class ApiRepository {

  Future<SearchImageResultEntity> getSearchImageList(String query, String? sort, int? page, int? size);


}