import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/domain/entity/image_info_entitiy.dart';
import 'package:search_image/domain/entity/search_image_list_meta_entity.dart';
import 'package:search_image/domain/usecase/favorite_image_use_case.dart';
import 'package:search_image/domain/usecase/search_image_use_case.dart';
import 'package:search_image/presentation/ui/state/search_image_state.dart';

final searchViewModelProvider =
StateNotifierProvider<SearchImageViewModel, SearchImageState>(
        (ref) => SearchImageViewModel());

final searchQueryProvider = StateProvider<String>((ref) => '');

final scrollPositionProvider = StateProvider<double>((ref) => 0.0);


class SearchImageViewModel extends StateNotifier<SearchImageState> {
  SearchImageViewModel() : super(SearchImageState());

  final _searchImageUseCase = SearchImageUseCase();
  final _favoriteImageUseCase = FavoriteImageUseCase();

  List<ImageInfoEntity> _searchImageEntityList = [];
  SearchImageResultMetaEntity? _searchResultMeta;
  int _page = 1;
  String? _query;

  Future<void> searchImages(String query) async {
    _reset();

    if (query.isEmpty) {
      state = SearchImageState(imageInfoEntityList: []);
      return;
    }

    _query = query;
    final searchImageListEntity = await _searchImageUseCase.getSearchImageList(query, _page++);
    _searchResultMeta = searchImageListEntity.searchImageResultMetaEntity;
    _searchImageEntityList = searchImageListEntity.imageInfoEntityList;
    state = SearchImageState(imageInfoEntityList: _searchImageEntityList);
  }

  Future<void> loadCurrentSearchImages() async {
    if(_searchImageEntityList.isEmpty){
      return;
    }
    final favoriteImageList = await _favoriteImageUseCase.getFavoriteImageList();
    for (var searchImage in _searchImageEntityList) {
      searchImage.isFavorite = false; // 초기화
      for (var favoriteImage in favoriteImageList) {
        if (favoriteImage.uniqueId == searchImage.uniqueId) {
          searchImage.isFavorite = true;
        }
      }
    }

    state = SearchImageState(imageInfoEntityList: _searchImageEntityList);
  }

  Future<void> loadMoreSearchImages() async {
    log('#### _page:$_page');

    // 검색결과가 더이상 없을 경우
    if (_searchResultMeta?.isEnd == true) {
      return;
    }

    // 검색어가 없는 경우
    if (_query?.isEmpty == true) {
      state = SearchImageState(imageInfoEntityList: []);
      return;
    }

    final searchImageListEntity =
        await _searchImageUseCase.getSearchImageList(_query!, _page++);
    _searchResultMeta = searchImageListEntity.searchImageResultMetaEntity;
    _searchImageEntityList += searchImageListEntity.imageInfoEntityList;
    state = SearchImageState(imageInfoEntityList: _searchImageEntityList);
  }

  Future<void> addFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    log('#### addFavoriteImage');
    await _favoriteImageUseCase.addFavoriteImage(imageInfoEntity);
    loadCurrentSearchImages();
  }

  Future<void> removeFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    await _favoriteImageUseCase.removeFavoriteImage(imageInfoEntity);
    loadCurrentSearchImages();
  }

  Future<void> syncFavoriteImage(ImageInfoEntity imageInfoEntity) async {
    for (var searchImage in _searchImageEntityList) {
      if (searchImage.uniqueId == imageInfoEntity.uniqueId) {
        searchImage.isFavorite = imageInfoEntity.isFavorite;
      }
    }
    state = SearchImageState(imageInfoEntityList: _searchImageEntityList);
  }



  void _reset() {
    _page = 1;
    _query = null;
    _searchImageEntityList = [];
    _searchResultMeta = null;
  }
}
