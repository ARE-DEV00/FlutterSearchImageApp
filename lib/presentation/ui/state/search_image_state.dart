import 'package:search_image/data/remote/model/search_image_response.dart';
import 'package:search_image/domain/entity/image_info_entitiy.dart';

class SearchImageState {
  final SearchResultMeta? searchResultMeta;
  final List<ImageInfoEntity> imageInfoEntityList;

  SearchImageState(
      {this.searchResultMeta, this.imageInfoEntityList = const []});

  SearchImageState copyWith(
      {SearchResultMeta? searchResultMeta,
      List<ImageInfoEntity>? imageInfoEntityList}) {
    return SearchImageState(
      searchResultMeta: searchResultMeta ?? this.searchResultMeta,
      imageInfoEntityList: imageInfoEntityList ?? this.imageInfoEntityList,
    );
  }
}
