import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/domain/entity/search_image_entity.dart';
import 'package:search_image/domain/usecase/search_image_use_case.dart';

class Home extends ConsumerWidget {
  final textQueryController = TextEditingController();
  final textQueryProvider = StateProvider<String>((ref) => "");

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getSearchImageListProvider = FutureProvider.autoDispose<List<SearchImageEntity>>((ref) {
      final query = ref.watch(textQueryProvider);
      if(query.isEmpty) {
        return Future.value([]);
      }
      return SearchImageUseCase().getSearchImageList(query, 1);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: const Text(
          "Search Image",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000)),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFFFFF),
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
                    onPressed: () {
                      ref.read(textQueryProvider.notifier).state = textQueryController.text;
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final searchResults = ref.watch(getSearchImageListProvider);
                  return searchResults.when(
                    data: (images) => ListView.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(images[index].displaySitename),
                          leading: Image.network(images[index].imageUrl!),
                        );
                      },
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (e, stack) => Text('Error: $e'),
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