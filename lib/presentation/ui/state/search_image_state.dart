import 'package:search_image/domain/entity/search_image_entity.dart';

class SearchImageState {
  final SearchImageEntity? searchImageEntity;
  final List<SearchImageEntity> searchImageEntityList;

  SearchImageState({this.searchImageEntity, this.searchImageEntityList = const []});

  SearchImageState copyWith({SearchImageEntity? searchImageEntity, List<SearchImageEntity>? searchImageEntityList}) {
    return SearchImageState(
      searchImageEntity: searchImageEntity ?? this.searchImageEntity,
      searchImageEntityList: searchImageEntityList ?? this.searchImageEntityList,
    );
  }
}