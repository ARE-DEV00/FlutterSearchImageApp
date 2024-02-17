import 'package:json_annotation/json_annotation.dart';

part 'search_image_response.g.dart';

@JsonSerializable()
class SearchResultMeta {
  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'pageable_count')
  final int pageableCount;
  @JsonKey(name: 'is_end')
  final bool isEnd;

  SearchResultMeta({
    required this.totalCount,
    required this.pageableCount,
    required this.isEnd,
  });

  factory SearchResultMeta.fromJson(Map<String, dynamic> json) => _$SearchResultMetaFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultMetaToJson(this);
}

@JsonSerializable()
class ImageInfo {
  final String collection;
  @JsonKey(name: 'thumbnail_url')
  final String thumbnailUrl;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final int width;
  final int height;
  @JsonKey(name: 'display_sitename')
  final String displaySitename;
  @JsonKey(name: 'doc_url')
  final String docUrl;
  final String datetime;

  ImageInfo({
    required this.collection,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.displaySitename,
    required this.docUrl,
    required this.datetime,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) => _$ImageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ImageInfoToJson(this);
}

@JsonSerializable()
class SearchImageResponse {
  final SearchResultMeta meta;
  final List<ImageInfo> documents;

  SearchImageResponse({
    required this.meta,
    required this.documents,
  });

  factory SearchImageResponse.fromJson(Map<String, dynamic> json) => _$SearchImageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchImageResponseToJson(this);
}