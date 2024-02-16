import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:search_image/data/model/sample_request.dart';
import 'package:search_image/data/model/sample_response.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: "https://dapi.kakao.com/v2/search/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;


  @GET("image")
  Future<SampleResponse> createSample(@Body() SampleRequest sampleRequest);

}