import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:search_image/data/remote/model/search_image_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://dapi.kakao.com/v2/search/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("image")
  Future<SearchImageResponse> getSearchImageList(
      @Query('query') String query,
      @Query('sort') String? sort,
      @Query('page') int? page,
      @Query('size') int? size);
}
