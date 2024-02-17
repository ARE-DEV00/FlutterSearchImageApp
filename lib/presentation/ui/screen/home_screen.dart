import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_image/presentation/ui/screen/favorite_list_screen.dart';
import 'package:search_image/presentation/ui/screen/search_image_list_screen.dart';

final bottomNavigationProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final screens = [
      SearchImageListScreen(),
      FavoriteListScreen()
    ];
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => ref.read(bottomNavigationProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
