import 'package:search_image/domain/entity/sample_entity.dart';

abstract class ApiRepository {

  Future<SampleEntity?> createSample(String description);


}