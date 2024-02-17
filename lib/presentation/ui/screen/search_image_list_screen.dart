import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/presentation/constants/RouteName.dart';
import 'package:search_image/presentation/ui/state/search_image_state.dart';
import 'package:search_image/presentation/ui/view_model/search_image_view_model.dart';
final searchViewModelProvider =
StateNotifierProvider<SearchImageViewModel, SearchImageState>(
        (ref) => SearchImageViewModel());

class SearchImageListScreen extends ConsumerWidget {
  SearchImageListScreen({Key? key}) : super(key: key);
  final textQueryController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          "Search Image",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: textQueryController,
                decoration: InputDecoration(
                  labelText: "Search",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => ref
                        .read(searchViewModelProvider.notifier)
                        .searchImages(textQueryController.text),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final searchState = ref.watch(searchViewModelProvider);
                  final searchResults = searchState.searchImageEntityList;
                  if (searchResults.isEmpty) {
                    return const Center(child: Text("검색된 이미지가 없습니다."));
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final imageUrl = searchResults[index].imageUrl ?? '';
                      return GridTile(
                        header: Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.all(1.0),
                          child: IconButton(
                            icon: const Icon(Icons.favorite_outline, color: Colors.white),
                            onPressed: () {
                            },
                          ),
                        ),
                        footer: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.black54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  searchResults[index].displaySitename ?? 'Unknown',
                                  style: const TextStyle(fontSize: 12, color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(RouteName.imageViewScreen, arguments: imageUrl);
                          },
                          child: imageUrl.isNotEmpty
                              ? Image.network(imageUrl, fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error))
                              : const Icon(Icons.image_not_supported),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}