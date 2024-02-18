import 'package:search_image/domain/entity/image_info_entitiy.dart';

abstract class DataBaseRepository {

  Future<List<ImageInfoEntity>> getFavoriteImageList();

  Future<void> addFavoriteImage(ImageInfoEntity imageInfoEntity);

  Future<void> removeFavoriteImage(ImageInfoEntity imageInfoEntity);

  Future<bool> isExistFavoriteImage(ImageInfoEntity imageInfoEntity);

}