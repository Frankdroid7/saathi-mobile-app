import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saathi/custom_widgets/action_button.dart';
import 'package:saathi/custom_widgets/header_card.dart';
import 'package:saathi/features/save/application/savings_service.dart';
import 'package:saathi/styles.dart';
import 'package:saathi/utils/widget_utils/saathiModalBottomSheet.dart';

import 'custom_widget/withdraw_savings_widgdet.dart';

class SavePageView extends StatelessWidget {
  const SavePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderCard(
          actionCardOnTap: () {},
          actionCardTitle: 'Withdraw/Add Savings',
          bodyWidget: RichText(
            text: TextSpan(
              text: '₹ ',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: '7,000 '),
                TextSpan(
                  text: 'in savings',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.5)),
                )
              ],
            ),
          ),
          // bodyWidget: SavingsHeaderCardBodyWidget(),
          subtitleText: RichText(
            text: TextSpan(
              text: 'You are on track to earn ',
              style:
                  TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5)),
              children: const [
                TextSpan(
                  text: '7% interest in 12 months',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          titleWidget: Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.account_balance_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'AnyBank',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.5)),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        ActionButton(
          title: 'Request Activity',
          icon: const Icon(Icons.history),
          onPressed: () {},
        ),
      ],
    );
  }
}

showWithdrawSavingsBottomSheet(BuildContext context) {
  saathiModalBottomSheet(
    context,
    child: const Text(''),
    // child: const WithdrawSavingsWidget(),
  );
}

// class SavingsHeaderCardBodyWidget extends ConsumerWidget {
//   const SavingsHeaderCardBodyWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ref.watch(getSavingsFuture).when(
//         data: (data) {
//           return RichText(
//             text: TextSpan(
//               text: '₹ ',
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 TextSpan(text: data!.amount.toString()),
//                 TextSpan(
//                   text: 'savings',
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white.withOpacity(0.5)),
//                 )
//               ],
//             ),
//           );
//         },
//         error: (error, stackTrace) {
//           return Text(
//             'No data at the moment',
//             style: TextStyle(color: Colors.white),
//           );
//         },
//         loading: () => Center(child: CircularProgressIndicator()));
//   }
// }
