class ImageInfoEntity {
  final String uniqueId; /// 검색을 위한 UniqueId 추가

  final String collection;
  final String thumbnailUrl;
  final String imageUrl;
  final int width;
  final int height;
  final String docUrl;
  final String displaySitename;
  final String datetime;
  bool isFavorite = false; /// 즐겨찾기 여부 추가

  ImageInfoEntity({
    required this.collection,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.docUrl,
    required this.displaySitename,
    required this.datetime,
    required this.uniqueId,
    required this.isFavorite,
  });
}
