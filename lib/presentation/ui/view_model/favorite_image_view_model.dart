import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/domain/entity/image_info_entitiy.dart';
import 'package:search_image/domain/usecase/favorite_image_use_case.dart';
import 'package:search_image/presentation/ui/state/favorite_image_state.dart';

class FavoriteImageViewModel extends StateNotifier<FavoriteImageState> {
  FavoriteImageViewModel() : super(FavoriteImageState());

  final _favoriteImageUseCase = FavoriteImageUseCase();

  List<ImageInfoEntity> _favoriteImageEntityList = [];

  Future<void> getFavoriteImages() async {
    reset();
    final favoriteImageList =
        await _favoriteImageUseCase.getFavoriteImageList();
    _favoriteImageEntityList = favoriteImageList;
    state = FavoriteImageState(imageInfoEntityList: _favoriteImageEntityList);
  }

  Future<void> addFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    await _favoriteImageUseCase.addFavoriteImage(imageInfoEntity);
    for (var element in _favoriteImageEntityList) {
      if (element.uniqueId == imageInfoEntity.uniqueId) {
        element.isFavorite = true;
      }
    }
    state = FavoriteImageState(imageInfoEntityList: _favoriteImageEntityList);
  }

  Future<void> removeFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    await _favoriteImageUseCase.removeFavoriteImage(imageInfoEntity);
    for (var element in _favoriteImageEntityList) {
      if (element.uniqueId == imageInfoEntity.uniqueId) {
        element.isFavorite = false;
      }
    }
    _favoriteImageEntityList.remove(imageInfoEntity);
    state = FavoriteImageState(imageInfoEntityList: _favoriteImageEntityList);
  }

  void reset() {
    _favoriteImageEntityList = [];
  }
}
