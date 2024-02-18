import 'package:json_annotation/json_annotation.dart';
import 'package:search_image/data/remote/model/image_info_response.dart';
import 'package:search_image/data/remote/model/search_result_meta_response.dart';

part 'search_image_response.g.dart';

@JsonSerializable()
class SearchImageResponse {
  final SearchResultMetaResponse meta;
  final List<ImageInfoResponse> documents;

  SearchImageResponse({
    required this.meta,
    required this.documents,
  });

  factory SearchImageResponse.fromJson(Map<String, dynamic> json) => _$SearchImageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchImageResponseToJson(this);
}