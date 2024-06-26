import 'package:search_image/domain/entity/image_info_entitiy.dart';

class FavoriteImageState {
  final List<ImageInfoEntity> imageInfoEntityList;

  FavoriteImageState({this.imageInfoEntityList = const []});

  FavoriteImageState copyWith({List<ImageInfoEntity>? imageInfoEntityList}) {
    return FavoriteImageState(
      imageInfoEntityList: imageInfoEntityList ?? this.imageInfoEntityList,
    );
  }
}
