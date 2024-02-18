// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_meta_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultMetaResponse _$SearchResultMetaResponseFromJson(
        Map<String, dynamic> json) =>
    SearchResultMetaResponse(
      totalCount: json['total_count'] as int,
      pageableCount: json['pageable_count'] as int,
      isEnd: json['is_end'] as bool,
    );

Map<String, dynamic> _$SearchResultMetaResponseToJson(
        SearchResultMetaResponse instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'pageable_count': instance.pageableCount,
      'is_end': instance.isEnd,
    };
