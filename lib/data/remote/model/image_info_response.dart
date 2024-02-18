import 'package:json_annotation/json_annotation.dart';

part 'image_info_response.g.dart';

@JsonSerializable()
class ImageInfoResponse {
  final String collection;
  @JsonKey(name: 'thumbnail_url')
  final String thumbnailUrl;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final int width;
  final int height;
  @JsonKey(name: 'display_sitename')
  final String displaySiteName;
  @JsonKey(name: 'doc_url')
  final String docUrl;
  final String datetime;

  ImageInfoResponse({
    required this.collection,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.displaySiteName,
    required this.docUrl,
    required this.datetime,
  });

  factory ImageInfoResponse.fromJson(Map<String, dynamic> json) => _$ImageInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ImageInfoResponseToJson(this);
}
