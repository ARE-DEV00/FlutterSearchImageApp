import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/presentation/constants/RouteName.dart';
import 'package:search_image/presentation/ui/view_model/search_image_view_model.dart';

class SearchImageListScreen extends ConsumerWidget {
  SearchImageListScreen({Key? key}) : super(key: key);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textQueryController = TextEditingController(text: ref.watch(searchQueryProvider));

    void updateSearchQuery(String query) {
      ref.read(searchQueryProvider.notifier).state = query;
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data
        log('##### _scrollController');
        ref.read(searchViewModelProvider.notifier).loadMoreSearchImages();
      }
    });

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
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_scrollController.hasClients) {
                          _scrollController.jumpTo(0);
                        }
                        ref
                            .read(searchViewModelProvider.notifier)
                            .searchImages(textQueryController.text);
                      }),

                ),
                onSubmitted: (String value) {
                  updateSearchQuery(value);

                  FocusScope.of(context).unfocus();
                  if (_scrollController.hasClients) {
                    _scrollController.jumpTo(0);
                  }
                  ref
                      .read(searchViewModelProvider.notifier)
                      .searchImages(textQueryController.text);
                },
                textInputAction: TextInputAction.search,
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final searchState = ref.watch(searchViewModelProvider);
                  final searchResults = searchState.imageInfoEntityList;
                  if (searchResults.isEmpty) {
                    return const Center(child: Text("검색된 이미지가 없습니다."));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref
                          .read(searchViewModelProvider.notifier)
                          .searchImages(textQueryController.text);
                    },
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final imageUrl = searchResults[index].imageUrl ?? '';
                        final isFavorite = searchResults[index].isFavorite;
                        return GridTile(
                            header: Container(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(1.0),
                              child: IconButton(
                                icon: isFavorite? const Icon(Icons.favorite,
                                    color: Colors.red):const Icon(Icons.favorite_outline,
                                    color: Colors.white),
                                onPressed: () async {
                                  if(!isFavorite){
                                    ref.read(searchViewModelProvider.notifier).addFavoriteImage(searchResults[index]);
                                  }else{
                                    ref.read(searchViewModelProvider.notifier).removeFavoriteImage(searchResults[index]);
                                  }
                                },
                              )
                            ),
                            footer: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.black54,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      searchResults[index].displaySitename ??
                                          'Unknown',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RouteName.imageViewScreen,
                                    arguments: imageUrl);
                              },
                              child: imageUrl.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : const Icon(Icons.image_not_supported),
                            ));
                      },
                    ),
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
