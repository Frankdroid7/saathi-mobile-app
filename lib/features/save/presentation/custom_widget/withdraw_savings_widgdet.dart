import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saathi/custom_widgets/action_button.dart';
import 'package:saathi/features/goal/domain/goal_model.dart';
import 'package:saathi/features/save/application/savings_service.dart';
import 'package:saathi/features/save/domain/savings_model.dart';
import 'package:saathi/utils/api_call_enum.dart';

import '../../../../custom_widgets/custom_textformfield.dart';
import '../../../../styles.dart';

class WithdrawSavingsWidget extends ConsumerStatefulWidget {
  final GoalModel goalModel;
  const WithdrawSavingsWidget({Key? key, required this.goalModel})
      : super(key: key);

  @override
  _WithdrawSavingsWidgetState createState() => _WithdrawSavingsWidgetState();
}

class _WithdrawSavingsWidgetState extends ConsumerState<WithdrawSavingsWidget> {
  TextEditingController amountCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ApiCallEnum apiCallEnum = ref.watch(savingsServiceStateNotifierProvider);
    SavingsService savingsService =
        ref.read(savingsServiceStateNotifierProvider.notifier);

    ref.listen(savingsServiceStateNotifierProvider, (previous, current) {
      if (current == ApiCallEnum.success) {
        Navigator.of(context).pop();
      }
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Withdraw Savings/Add',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          const Text('Please enter an amount to withdraw'),
          const SizedBox(height: 20),
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                children: [
                  const Text(
                    '₹',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      autoFocus: true,
                      controller: amountCtrl,
                      hintText: '',
                      isNumberField: true,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your withdrawal will be paid to your linked account at HDFC:\n \n IFSC: HDFC0123456 Account: 12345678910',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 10),
          apiCallEnum == ApiCallEnum.loading
              ? const Center(child: CircularProgressIndicator())
              : apiCallEnum == ApiCallEnum.error
                  ? const Text(
                      'Something went wrong please try again',
                      style: TextStyle(color: Colors.red),
                    )
                  : const SizedBox.shrink(),
          const SizedBox(height: 8),
          ActionButton(
              icon: const Icon(Icons.arrow_forward_rounded),
              onPressed: () {
                if (amountCtrl.text.isNotEmpty) {
                  savingsService.withdrawSavings(
                    savingsModel: SavingsModel(
                      amount: widget.goalModel.amount -
                          double.parse(amountCtrl.text),
                      goalId: widget.goalModel.id!,
                      durationAmount: (widget.goalModel.amount -
                              double.parse(amountCtrl.text)) /
                          widget.goalModel.duration,
                    ),
                  );
                }
              },
              title: 'Withdraw'),
          const SizedBox(height: 8),
          ActionButton(
              icon: const Icon(Icons.arrow_forward_rounded),
              onPressed: () {
                if (amountCtrl.text.isNotEmpty) {
                  savingsService.addSavings(
                    savingsModel: SavingsModel(
                      goalId: widget.goalModel.id!,
                      amount: widget.goalModel.amount +
                          double.parse(amountCtrl.text),
                      durationAmount: (widget.goalModel.amount +
                              double.parse(amountCtrl.text)) /
                          widget.goalModel.duration,
                    ),
                  );
                }
              },
              title: 'Add'),
        ],
      ),
    );
  }
}
