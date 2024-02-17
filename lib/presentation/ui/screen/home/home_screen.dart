import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/presentation/ui/state/search_image_state.dart';
import 'package:search_image/presentation/ui/view_model/search_image_view_model.dart';

final searchViewModelProvider =
    StateNotifierProvider<SearchImageViewModel, SearchImageState>((ref) => SearchImageViewModel());

class HomeScreen extends ConsumerWidget {
  final textQueryController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final imageUrl = searchResults[index].imageUrl ?? '';
                      return ListTile(
                        title: Text(
                            searchResults[index].displaySitename ?? 'Unknown'),
                        leading: imageUrl.isNotEmpty
                            ? Image.network(imageUrl,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error))
                            : const Icon(Icons.image_not_supported),
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
