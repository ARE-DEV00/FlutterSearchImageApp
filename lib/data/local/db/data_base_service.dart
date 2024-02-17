import 'package:isar/isar.dart';
import 'package:search_image/data/local/db/collection/favorite_image_collection.dart';

class DataBaseService {
  final Isar isar;

  DataBaseService(this.isar);

  Future<List<FavoriteImageCollection>> getFavoriteImageList() async {
    final data = await isar.favoriteImageCollections.where().findAll();
    return data;
  }

  Future<FavoriteImageCollection?> getFavoriteImageByUniqueId(String uniqueId) async {
    final favoriteImageCollection = await isar.favoriteImageCollections
        .filter()
        .uniqueIdEqualTo(uniqueId)
        .findFirst();
    return favoriteImageCollection;
  }

  Future<void> addFavoriteImage(FavoriteImageCollection favoriteImageCollection) async {
    await isar.writeTxn(() async {
      await isar.favoriteImageCollections.put(favoriteImageCollection);
    });
  }

  Future<void> deleteFavoriteImageByUniqueId(String uniqueId) async {
    await isar.writeTxn(() async {
      final favoriteImage = await isar.favoriteImageCollections
          .filter()
          .uniqueIdEqualTo(uniqueId)
          .findFirst();

      if (favoriteImage != null) {
        await isar.favoriteImageCollections.delete(favoriteImage.id);
      }
    });
  }
}
