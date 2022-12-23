import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saathi/custom_widgets/custom_textformfield.dart';
import 'package:saathi/features/goal/application/goal_service.dart';
import 'package:saathi/features/goal/data/goal_repository_impl.dart';
import 'package:saathi/features/goal/domain/goal_model.dart';
import 'package:saathi/features/goal/presentation/custom_widgets/unsplash_imagelist_widget.dart';
import 'package:saathi/utils/api_call_enum.dart';
import 'package:saathi/utils/navigation_utils.dart';
import 'package:uuid/uuid.dart';

import '../../../../custom_widgets/action_button.dart';
import '../../../../styles.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widget_utils/saathiModalBottomSheet.dart';
import 'duration_container.dart';

class CreateGoalWidget extends ConsumerStatefulWidget {
  final GoalModel? goalModel;
  const CreateGoalWidget({Key? key, this.goalModel}) : super(key: key);

  @override
  _CreateGoalWidgetState createState() => _CreateGoalWidgetState();
}

class _CreateGoalWidgetState extends ConsumerState<CreateGoalWidget> {
  int durationIndexSelected = 0;
  String? formattedDateTime;
  DateTime? pickedDateTime;
  bool otherDurationVisible = false;

  String? pickedImage;
  TextEditingController descCtrl = TextEditingController();
  TextEditingController goalNameCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  Map<int, String> durationListMap = {
    1: 'month',
    2: 'months',
    3: 'months',
    6: 'months',
    12: 'months',
    -1: 'Other'
  };

  int? duration;
  String? durationType;
  double? durationAmount;

  @override
  void initState() {
    super.initState();
    if (widget.goalModel != null) {
      pickedImage = widget.goalModel!.imgUrl;
      goalNameCtrl.text = widget.goalModel!.name;
      descCtrl.text = widget.goalModel!.description;
      durationIndexSelected =
          durationListMap.containsKey(widget.goalModel!.duration)
              ? widget.goalModel!.duration
              : 0;
      amountCtrl.text = widget.goalModel!.amount.toString();
      duration = widget.goalModel!.duration;
      durationType = widget.goalModel!.durationType;
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiCallEnum apiCallEnum = ref.watch(goalServiceStateNotifierProvider);
    GoalService goalService =
        ref.read(goalServiceStateNotifierProvider.notifier);

    ref.listen(goalServiceStateNotifierProvider, (previous, current) {
      if (current == ApiCallEnum.success) {
        if (widget.goalModel != null) {
          popScreen(context);
        } else {
          popScreen(context);
          showSnackbar(context, 'Goal created');
          ref.refresh(getGoalListFuture.future);
        }
      } else if (current == ApiCallEnum.error) {
        popScreen(context);
        showSnackbar(context, goalService.errMsg!);
        ;
      }
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter a goal name before you pick an image.'),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              if (goalNameCtrl.text.isNotEmpty) {
                String? imageUrl =
                    await showUnsplashImagesSheet(context, goalNameCtrl.text);
                if (imageUrl != null) {
                  setState(() => pickedImage = imageUrl);
                }
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: pickedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: pickedImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(
                      Icons.image,
                      size: 80,
                    ),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
              controller: goalNameCtrl, hintText: 'Enter goal name'),
          const SizedBox(height: 10),
          CustomTextFormField(
              controller: descCtrl, hintText: 'Enter goal description'),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: amountCtrl,
            hintText: 'Enter amount you want to save',
            isNumberField: true,
          ),
          const SizedBox(height: 10),
          const Text(
            'How long do you want to save for?',
            style: TextStyle(color: AppColors.primaryTextColor),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: durationListMap.entries.map((entry) {
                  int index = entry.key;
                  String value = entry.key.toString();

                  return DurationContainer(
                    duration: index,
                    selected: (widget.goalModel != null &&
                            widget.goalModel!.duration == int.parse(value) &&
                            widget.goalModel!.durationType == entry.value)
                        ? index == durationIndexSelected
                            ? true
                            : false
                        : index == durationIndexSelected
                            ? true
                            : false,
                    // selected: index == durationIndexSelected ? true : false,
                    onTap: () {
                      setState(() {
                        durationIndexSelected = index;
                        otherDurationVisible = value == '-1';
                        if (otherDurationVisible == false) {
                          formattedDateTime = null;
                        }
                      });

                      if (value != 'Other') {
                        duration = int.parse(value);
                        durationType = value == '1' ? 'month' : 'months';
                      } else {
                        duration = null;
                        durationType = null;
                      }
                    },
                  );
                }).toList()),
          ),
          Visibility(
            visible: otherDurationVisible,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select a custom date',
                  style: TextStyle(color: AppColors.primaryTextColor),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 120,
                  child: ActionButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () async {
                        final dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (dateTime != null) {
                          setState(() => formattedDateTime =
                              DateFormat.yMMMMd().format(dateTime));
                          pickedDateTime = dateTime;
                          DateTime currentDateTime = DateTime.now();
                          int differenceInDays = pickedDateTime!
                              .difference(currentDateTime)
                              .inDays;
                          if (differenceInDays ~/ 30 > 1) {
                            duration = differenceInDays ~/ 30;
                            durationType = 'months';
                          } else if (differenceInDays ~/ 30 == 1) {
                            duration = 1;
                            durationType = 'month';
                          } else {
                            if (differenceInDays > 1) {
                              duration = differenceInDays;
                              durationType = 'days';
                            } else {
                              duration = 1;
                              durationType = 'day';
                            }
                          }
                        }
                      },
                      title: 'Select'),
                ),
                const SizedBox(height: 10),
                formattedDateTime != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Saving until:  '),
                          Text(
                            formattedDateTime!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.primaryTextColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          apiCallEnum == ApiCallEnum.loading
              ? const Center(child: CircularProgressIndicator())
              : ActionButton(
                  onPressed: () {
                    if (pickedImage != null &&
                        duration != null &&
                        durationType != null) {
                      durationAmount =
                          double.parse(amountCtrl.text) / duration!;

                      //If GoalModel is not null, it means there is already a GoalModel so we just update the goal.
                      if (widget.goalModel == null) {
                        goalService.createGoal(GoalModel(
                          id: const Uuid().v4(),
                          name: goalNameCtrl.text,
                          imgUrl: pickedImage!,
                          amount: double.parse(amountCtrl.text),
                          duration: duration!,
                          description: descCtrl.text,
                          durationType: durationType!,
                          durationAmount: durationAmount!,
                          isActive: true,
                          createdAt: DateTime.now().toString(),
                        ));
                      } else {
                        goalService.updateGoal(GoalModel(
                          isActive: widget.goalModel!.isActive,
                          durationAmount: durationAmount!,
                          id: widget.goalModel!.id,
                          name: goalNameCtrl.text,
                          imgUrl: pickedImage!,
                          amount: double.parse(amountCtrl.text),
                          duration: duration!,
                          description: descCtrl.text,
                          durationType: durationType!,
                        ));
                      }
                    }
                  },
                  title:
                      widget.goalModel == null ? 'Create Goal' : 'Update goal')
        ],
      ),
    );
  }
}

Future<String?> showUnsplashImagesSheet(BuildContext context, String query) {
  return saathiModalBottomSheet<String?>(context,
      child: UnsplashImageListWidget(
          query: query, onImageTap: (img) => Navigator.pop(context, img)),
      bottomSheetHeight: MediaQuery.of(context).size.height * 0.6);
}
