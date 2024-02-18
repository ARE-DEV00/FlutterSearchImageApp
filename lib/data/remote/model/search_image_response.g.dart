// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchImageResponse _$SearchImageResponseFromJson(Map<String, dynamic> json) =>
    SearchImageResponse(
      meta: SearchResultMetaResponse.fromJson(
          json['meta'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => ImageInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchImageResponseToJson(
        SearchImageResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'documents': instance.documents,
    };
