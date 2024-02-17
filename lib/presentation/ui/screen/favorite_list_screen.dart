import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/presentation/constants/RouteName.dart';
import 'package:search_image/presentation/ui/state/favorite_image_state.dart';
import 'package:search_image/presentation/ui/view_model/favorite_image_view_model.dart';

final favoriteViewModelProvider =
StateNotifierProvider<FavoriteImageViewModel, FavoriteImageState>(
        (ref) => FavoriteImageViewModel());

class FavoriteListScreen extends ConsumerWidget {
  FavoriteListScreen({Key? key}) : super(key: key);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(favoriteViewModelProvider.notifier).getFavoriteImages();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load more data
        log('##### _scrollController');
        ref.read(favoriteViewModelProvider.notifier).getFavoriteImages();
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          "Favorite Image",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Consumer(
          builder: (context, ref, child) {
            final favoriteImageState = ref.watch(favoriteViewModelProvider);
            final imageInfoEntityList = favoriteImageState.imageInfoEntityList;
            if (imageInfoEntityList.isEmpty) {
              return const Center(child: Text("즐겨찾기된 이미지가 없습니다."));
            }
            return RefreshIndicator(
              onRefresh: () async {
                ref
                    .read(favoriteViewModelProvider.notifier)
                    .getFavoriteImages();
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
                itemCount: imageInfoEntityList.length,
                itemBuilder: (context, index) {
                  final imageUrl = imageInfoEntityList[index].imageUrl ?? '';
                  final isFavorite = imageInfoEntityList[index].isFavorite;
                  log('#### isFavorite:$isFavorite');
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
                                ref.read(favoriteViewModelProvider.notifier).addFavoriteImage(imageInfoEntityList[index]);
                              }else{
                                ref.read(favoriteViewModelProvider.notifier).removeFavoriteImage(imageInfoEntityList[index]);
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
                                imageInfoEntityList[index].displaySitename ??
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
    );
  }
}
