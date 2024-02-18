// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultMeta _$SearchResultMetaFromJson(Map<String, dynamic> json) =>
    SearchResultMeta(
      totalCount: json['total_count'] as int,
      pageableCount: json['pageable_count'] as int,
      isEnd: json['is_end'] as bool,
    );

Map<String, dynamic> _$SearchResultMetaToJson(SearchResultMeta instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'pageable_count': instance.pageableCount,
      'is_end': instance.isEnd,
    };

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) => ImageInfo(
      collection: json['collection'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      imageUrl: json['image_url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      displaySiteName: json['display_sitename'] as String,
      docUrl: json['doc_url'] as String,
      datetime: json['datetime'] as String,
    );

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
      'collection': instance.collection,
      'thumbnail_url': instance.thumbnailUrl,
      'image_url': instance.imageUrl,
      'width': instance.width,
      'height': instance.height,
      'display_sitename': instance.displaySiteName,
      'doc_url': instance.docUrl,
      'datetime': instance.datetime,
    };

SearchImageResponse _$SearchImageResponseFromJson(Map<String, dynamic> json) =>
    SearchImageResponse(
      meta: SearchResultMeta.fromJson(json['meta'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => ImageInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchImageResponseToJson(
        SearchImageResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'documents': instance.documents,
    };
