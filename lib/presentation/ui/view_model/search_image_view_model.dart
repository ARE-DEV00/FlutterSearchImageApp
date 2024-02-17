import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/domain/usecase/search_image_use_case.dart';
import 'package:search_image/presentation/ui/state/search_image_state.dart';

class SearchImageViewModel extends StateNotifier<SearchImageState> {
  SearchImageViewModel() : super(SearchImageState());

  final _searchImageUseCase = SearchImageUseCase();

  Future<void> searchImages(String query) async {
    if (query.isEmpty) {
      state = SearchImageState(searchImageEntityList: []);
      return;
    }
    final images = await _searchImageUseCase.getSearchImageList(query, 1);
    state = SearchImageState(searchImageEntityList: images);
  }

//Test 코드
/*void setSingleImage() {
    final newImage = SearchImageEntity(displaySitename: 'test', imageUrl: 'http://test.com');
    state = state.copyWith(searchImageEntity: newImage);
  }*/
}
