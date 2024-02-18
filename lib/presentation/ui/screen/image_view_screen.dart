import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageViewScreen extends ConsumerWidget {
  const ImageViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String imageUrl =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: imageUrl.isNotEmpty
                  ? InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 10.0,
                      child: Image.network(imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, color: Colors.white)),
                    )
                  : const Icon(Icons.image_not_supported, color: Colors.white),
            ),
            Positioned(
              top: 50,
              left: 5,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
