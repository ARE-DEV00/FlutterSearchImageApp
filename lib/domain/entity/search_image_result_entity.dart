import 'package:search_image/domain/entity/image_info_entitiy.dart';
import 'package:search_image/domain/entity/search_image_list_meta_entity.dart';

class SearchImageResultEntity {
  SearchImageResultMetaEntity? searchImageResultMetaEntity;
  List<ImageInfoEntity> imageInfoEntityList;
  SearchImageResultEntity({this.searchImageResultMetaEntity, required this.imageInfoEntityList});
}
