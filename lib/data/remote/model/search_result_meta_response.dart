import 'package:json_annotation/json_annotation.dart';

part 'search_result_meta_response.g.dart';

@JsonSerializable()
class SearchResultMetaResponse {
  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'pageable_count')
  final int pageableCount;
  @JsonKey(name: 'is_end')
  final bool isEnd;

  SearchResultMetaResponse({
    required this.totalCount,
    required this.pageableCount,
    required this.isEnd,
  });

  factory SearchResultMetaResponse.fromJson(Map<String, dynamic> json) => _$SearchResultMetaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultMetaResponseToJson(this);
}