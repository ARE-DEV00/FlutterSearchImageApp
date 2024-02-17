import 'package:get_it/get_it.dart';
import 'package:search_image/data/local/db/collection/favorite_image_collection.dart';
import 'package:search_image/data/local/db/data_base_service.dart';
import 'package:search_image/data/utils/common_data_util.dart';
import 'package:search_image/domain/entity/image_info_entitiy.dart';
import 'package:search_image/domain/repository/data_base_repository.dart';

class DataBaseRepositoryImpl implements DataBaseRepository {
  final DataBaseService _dataBaseService = GetIt.instance<DataBaseService>();

  @override
  Future<void> addFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    final favoriteImageCollection = FavoriteImageCollection(
      uniqueId: CommonDataUtil.generateUniqueId(
          collection: imageInfoEntity.collection,
          displaySitename: imageInfoEntity.displaySitename,
          imageUrl: imageInfoEntity.imageUrl,
          datetime: imageInfoEntity.datetime),
      collection: imageInfoEntity.collection,
      thumbnailUrl: imageInfoEntity.thumbnailUrl,
      imageUrl: imageInfoEntity.imageUrl,
      width: imageInfoEntity.width,
      height: imageInfoEntity.height,
      docUrl: imageInfoEntity.docUrl,
      displaySitename: imageInfoEntity.displaySitename,
      datetime: imageInfoEntity.datetime,
      isFavorite: true,
    );
    await _dataBaseService.addFavoriteImage(favoriteImageCollection);
  }

  @override
  Future<List<ImageInfoEntity>> getFavoriteImageList() async {
    final favoriteImages = await _dataBaseService.getFavoriteImageList();
    return favoriteImages
        .map((favoriteImage) => ImageInfoEntity(
              uniqueId: CommonDataUtil.generateUniqueId(
                  collection: favoriteImage.collection ?? '',
                  displaySitename: favoriteImage.displaySitename ?? '',
                  imageUrl: favoriteImage.imageUrl ?? '',
                  datetime: favoriteImage.datetime ?? ''),
              collection: favoriteImage.collection ?? '',
              thumbnailUrl: favoriteImage.thumbnailUrl ?? '',
              imageUrl: favoriteImage.imageUrl ?? '',
              width: favoriteImage.width ?? 0,
              height: favoriteImage.height ?? 0,
              docUrl: favoriteImage.docUrl ?? '',
              displaySitename: favoriteImage.displaySitename ?? '',
              datetime: favoriteImage.datetime ?? '',
              isFavorite: true,
            ))
        .toList();
  }

  @override
  Future<bool> isExistFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    final uniqueId = CommonDataUtil.generateUniqueId(
        collection: imageInfoEntity.collection,
        displaySitename: imageInfoEntity.displaySitename,
        imageUrl: imageInfoEntity.imageUrl,
        datetime: imageInfoEntity.datetime);
    final favoriteImage =
        await _dataBaseService.getFavoriteImageByUniqueId(uniqueId);
    return favoriteImage != null;
  }

  @override
  Future<void> removeFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    final uniqueId = CommonDataUtil.generateUniqueId(
        collection: imageInfoEntity.collection,
        displaySitename: imageInfoEntity.displaySitename,
        imageUrl: imageInfoEntity.imageUrl,
        datetime: imageInfoEntity.datetime);

    await _dataBaseService.deleteFavoriteImageByUniqueId(uniqueId);
  }

}
