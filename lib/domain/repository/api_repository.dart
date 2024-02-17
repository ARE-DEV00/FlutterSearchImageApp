import 'package:search_image/domain/entity/search_image_entity.dart';

abstract class ApiRepository {

  Future<List<SearchImageEntity>> getSearchImageList(String query, String? sort, int? page, int? size);


}