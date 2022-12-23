import 'package:flutter/material.dart';
import 'package:saathi/custom_widgets/header_card.dart';
import 'package:saathi/styles.dart';

import '../../../custom_widgets/action_button.dart';

class InvestPageView extends StatelessWidget {
  const InvestPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderCard(
          actionCardOnTap: () {},
          actionCardTitle: 'View investment',
          bodyWidget: RichText(
            text: TextSpan(
              text: '₹ ',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: '12,000 '),
                TextSpan(
                  text: 'in investment',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.5)),
                )
              ],
            ),
          ),
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
                'Saathi investment holdings',
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
