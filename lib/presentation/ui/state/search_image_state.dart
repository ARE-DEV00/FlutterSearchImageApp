
import 'package:search_image/domain/entity/image_info_entitiy.dart';
import 'package:search_image/domain/entity/search_image_list_meta_entity.dart';

class SearchImageState {
  final SearchImageResultMetaEntity? searchImageResultMetaEntity;
  final List<ImageInfoEntity> imageInfoEntityList;

  SearchImageState(
      {this.searchImageResultMetaEntity, this.imageInfoEntityList = const []});

  SearchImageState copyWith(
      {SearchImageResultMetaEntity? searchImageResultMetaEntity,
      List<ImageInfoEntity>? imageInfoEntityList}) {
    return SearchImageState(
      searchImageResultMetaEntity: searchImageResultMetaEntity ?? this.searchImageResultMetaEntity,
      imageInfoEntityList: imageInfoEntityList ?? this.imageInfoEntityList,
    );
  }
}
