import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:saathi/features/goal/application/goal_service.dart';
import 'package:saathi/features/goal/data/goal_repository_impl.dart';
import 'package:saathi/features/goal/domain/goal_model.dart';
import 'package:saathi/features/goal/presentation/edit_goal.dart';
import 'package:saathi/features/save/application/savings_service.dart';
import 'package:saathi/features/save/presentation/custom_widget/withdraw_savings_widgdet.dart';
import 'package:saathi/utils/api_call_enum.dart';
import 'package:saathi/utils/navigation_utils.dart';
import 'package:saathi/utils/widget_utils/saathiModalBottomSheet.dart';

import '../../../custom_widgets/action_button.dart';
import '../../../utils/utils.dart';

class GoalDetailView extends ConsumerWidget {
  final String id;
  const GoalDetailView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ApiCallEnum apiCallEnum = ref.watch(goalServiceStateNotifierProvider);
    GoalService goalService =
        ref.watch(goalServiceStateNotifierProvider.notifier);

    ref.listen(goalServiceStateNotifierProvider, (previous, current) {
      if (current == ApiCallEnum.success) {
        Navigator.of(context).pop();
        if (goalService.actionType != null) {
          showSnackbar(context, goalService.actionType!);
        }
        ref.refresh(getGoalListFuture.future);
      } else if (current == ApiCallEnum.error) {
        showSnackbar(context, goalService.errMsg!);
      }
    });

    ref.listen(getSingleGoalFuture(id), (previous, current) {
      if (current.hasError) {
        popScreen(context);
        showSnackbar(context, 'Something went wrong, please try again');
      }
    });

    ref.listen(savingsServiceStateNotifierProvider, (previous, current) {
      if (current == ApiCallEnum.success) {
        ref.refresh(getSingleGoalFuture(id));
        ref.refresh(getGoalListFuture.future);
        showSnackbar(context,
            ref.read(goalServiceStateNotifierProvider.notifier).actionType!);
      }
    });

    return ref.watch(getSingleGoalFuture(id)).when(
      data: (data) {
        GoalModel goalModel = data!;
        print('DD-AMOUNT: ${goalModel.durationAmount}');
        return Scaffold(
          appBar: AppBar(
            title: Text(goalModel.name),
            actions: [
              PopupMenuButton(
                  onSelected: (str) =>
                      handleMenuClick(str, context, goalService),
                  itemBuilder: (context) {
                    return ['Edit', 'Delete']
                        .map((e) => PopupMenuItem(value: e, child: Text(e)))
                        .toList();
                  }),
            ],
          ),
          body: ModalProgressHUD(
            inAsyncCall: apiCallEnum == ApiCallEnum.loading,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: goalModel.imgUrl,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Description'),
                    const SizedBox(height: 4),
                    Text(
                      goalModel.description,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(thickness: 2),
                    const SizedBox(height: 10),
                    Text('Duration'),
                    const SizedBox(height: 4),
                    Text(
                      '${goalModel.duration.toString()} ${goalModel.durationType}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Divider(thickness: 2),
                    const SizedBox(height: 10),
                    const Text('Amount'),
                    const SizedBox(height: 4),
                    Text(
                      formatAmount(goalModel.amount),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Divider(thickness: 2),
                    const SizedBox(height: 10),
                    const Text('Duration amount:'),
                    const SizedBox(height: 4),
                    Text(
                      formatAmount(goalModel.durationAmount!),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(thickness: 2),
                    const SizedBox(height: 10),
                    const Text('Goal was created on:'),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat.yMMMMd()
                          .format(DateTime.parse(goalModel.createdAt!)),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(thickness: 2),
                    ActionButton(
                        icon: const Icon(Icons.arrow_forward_rounded),
                        onPressed: () {
                          saathiModalBottomSheet(context,
                              child:
                                  WithdrawSavingsWidget(goalModel: goalModel));
                        },
                        title: 'Withdraw/Add Savings'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (error, stack) {
        return Container(color: Colors.white);
      },
      loading: () {
        return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()));
      },
    );
  }

  handleMenuClick(String str, BuildContext context, GoalService goalService) {
    if (str == 'Edit') {
      navigateToScreen(context, const EditGoal());
    } else {
      goalService.deleteGoal(id);
    }
  }
}
