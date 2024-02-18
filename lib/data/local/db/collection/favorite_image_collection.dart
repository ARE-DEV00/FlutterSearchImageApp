import 'package:isar/isar.dart';

part 'favorite_image_collection.g.dart';

@Collection()
class FavoriteImageCollection {
  Id id = Isar.autoIncrement;
  final String uniqueId;
  String? collection;
  String? thumbnailUrl;
  String? imageUrl;
  int? width;
  int? height;
  String? docUrl;
  String? displaySiteName;
  String? datetime;
  bool isFavorite = false;

  FavoriteImageCollection({
    required this.uniqueId,
    this.collection,
    this.thumbnailUrl,
    this.imageUrl,
    this.width,
    this.height,
    this.docUrl,
    this.displaySiteName,
    this.datetime,
    required bool isFavorite,
  });
}
