// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfoResponse _$ImageInfoResponseFromJson(Map<String, dynamic> json) =>
    ImageInfoResponse(
      collection: json['collection'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      imageUrl: json['image_url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      displaySiteName: json['display_sitename'] as String,
      docUrl: json['doc_url'] as String,
      datetime: json['datetime'] as String,
    );

Map<String, dynamic> _$ImageInfoResponseToJson(ImageInfoResponse instance) =>
    <String, dynamic>{
      'collection': instance.collection,
      'thumbnail_url': instance.thumbnailUrl,
      'image_url': instance.imageUrl,
      'width': instance.width,
      'height': instance.height,
      'display_sitename': instance.displaySiteName,
      'doc_url': instance.docUrl,
      'datetime': instance.datetime,
    };
