class ImageInfoEntity {
  final String collection;
  final String thumbnailUrl;
  final String imageUrl;
  final int width;
  final int height;
  final String docUrl;
  final String? displaySitename;
  final String datetime;

  ImageInfoEntity({
    required this.collection,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.docUrl,
    this.displaySitename,
    required this.datetime,

  });
}
