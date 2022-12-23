import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saathi/features/goal/application/goal_service.dart';

class UnsplashImageListWidget extends ConsumerWidget {
  final String query;
  final Function(String) onImageTap;
  const UnsplashImageListWidget(
      {Key? key, required this.onImageTap, required this.query})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUnsplashImagesFuture(query)).when(
        data: (data) {
          if (data.isEmpty) {
            return const Text(
                'There are no available images for your goal name.');
          }
          return Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => onImageTap(data[index].imageUrl),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: data[index].imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
        error: (error, stackTrace) {
          return Text(error.toString());
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
