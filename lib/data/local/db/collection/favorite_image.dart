import 'package:isar/isar.dart';

part 'favorite_image.g.dart';

@collection
class FavoriteImage {
  Id id = Isar.autoIncrement;
  String? collection;
  String? thumbnailUrl;
  String? imageUrl;
  int? width;
  int? height;
  String? docUrl;
  String? displaySitename;
  String? datetime;
}
