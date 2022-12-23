import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saathi/features/goal/presentation/goal_detailview.dart';
import 'package:saathi/utils/navigation_utils.dart';

import '../../../../utils/utils.dart';
import '../../data/goal_repository_impl.dart';
import '../../domain/goal_model.dart';

class GoalCard extends ConsumerWidget {
  final GoalModel goalModel;
  const GoalCard({Key? key, required this.goalModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        if (goalModel.isActive) {
          ref.read(goalStateProvider.notifier).state = goalModel;
          navigateToScreen(context, GoalDetailView(id: goalModel.id!));
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: goalModel.imgUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goalModel.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          formatAmount(goalModel.amount),
                        ),
                      ),
                      Text(
                        '${goalModel.duration.toString()} ${goalModel.durationType}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
            goalModel.isActive
                ? const SizedBox.shrink()
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.withOpacity(0.6),
                    ),
                  ),
            goalModel.isActive
                ? const SizedBox.shrink()
                : const Center(
                    child: Icon(
                    Icons.warning_outlined,
                    color: Colors.black,
                    size: 30,
                  ))
          ],
        ),
      ),
    );
  }
}
