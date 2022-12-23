import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saathi/custom_widgets/action_button.dart';
import 'package:saathi/features/goal/application/goal_service.dart';
import 'package:saathi/features/goal/domain/goal_model.dart';
import 'package:saathi/features/goal/presentation/custom_widgets/create_goal_widget.dart';
import 'package:saathi/features/goal/presentation/goal_detailview.dart';
import 'package:saathi/styles.dart';
import 'package:saathi/utils/widget_utils/saathiModalBottomSheet.dart';

import '../../../utils/utils.dart';
import 'custom_widgets/duration_container.dart';
import 'custom_widgets/goal_card.dart';
import 'custom_widgets/unsplash_imagelist_widget.dart';

class GoalsPageView extends ConsumerWidget {
  const GoalsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ActionButton(
          title: 'Create new goal',
          icon: const Icon(Icons.add),
          onPressed: () => showCreateGoalSheet(context),
          buttonColor: AppColors.tertiaryColor,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ref.watch(getGoalListFuture).when(
              data: (data) {
                double totalAmount = 0.0;
                for (var element in data) {
                  if (element.isActive) {
                    totalAmount += element.amount;
                  }
                }
                return Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => ref.refresh(getGoalListFuture.future),
                        child: data.isEmpty
                            ? const Text(
                                'You have no goals at the moment, click the button above to create one.',
                                style: TextStyle(
                                    color: AppColors.primaryTextColor),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  GoalModel goalModel = data[index];
                                  return GoalCard(
                                    goalModel: GoalModel(
                                      id: goalModel.id,
                                      name: goalModel.name,
                                      isActive: goalModel.isActive,
                                      amount: goalModel.amount,
                                      duration: goalModel.duration,
                                      durationType: goalModel.durationType,
                                      description: goalModel.description,
                                      imgUrl: goalModel.imgUrl,
                                      createdAt: goalModel.createdAt,
                                    ),
                                  );
                                }),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Text('Total amount of savings goal:  '),
                            Expanded(
                              child: Text(
                                formatAmount(totalAmount),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, stack) {
                return Text('Something went wrong, please try again.$error');
              },
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
      ],
    );
  }
}

Future<void> showCreateGoalSheet(BuildContext context) {
  return saathiModalBottomSheet(
    context,
    bottomSheetHeight: MediaQuery.of(context).size.height * 0.9,
    child: const CreateGoalWidget(),
  );
}
