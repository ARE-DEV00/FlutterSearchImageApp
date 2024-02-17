import 'package:get_it/get_it.dart';
import 'package:search_image/data/local/db/repository/data_base_repository_impl.dart';
import 'package:search_image/data/remote/api/repository/api_repository_impl.dart';
import 'package:search_image/domain/entity/image_info_entitiy.dart';
import 'package:search_image/domain/entity/search_image_result_entity.dart';
import 'package:search_image/domain/enums/sort_type.dart';

import 'package:search_image/domain/repository/api_repository.dart';
import 'package:search_image/domain/repository/data_base_repository.dart';

class FavoriteImageUseCase {
  final DataBaseRepository _dataBaseRepository =
      GetIt.instance<DataBaseRepositoryImpl>();

  Future<void> addFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    await _dataBaseRepository.addFavoriteImage(imageInfoEntity);
  }

  Future<List<ImageInfoEntity>> getFavoriteImageList() async {
    return await _dataBaseRepository.getFavoriteImageList();
  }

  Future<bool> isExistFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    return await _dataBaseRepository.isExistFavoriteImage(imageInfoEntity);
  }

  Future<void> removeFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    await _dataBaseRepository.removeFavoriteImage(imageInfoEntity);
  }
}
