import 'package:flutter/material.dart';
import 'package:saathi/custom_widgets/header_card.dart';
import 'package:saathi/styles.dart';
import 'package:saathi/utils/widget_utils/saathiModalBottomSheet.dart';

import '../../../custom_widgets/action_button.dart';

class EarnPageView extends StatelessWidget {
  const EarnPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderCard(
            actionCardOnTap: () {},
            onEarnPageView: true,
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
                    text: 'requested',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.5)),
                  )
                ],
              ),
            ),
            actionCardTitle: 'Change Advance Request',
            subtitleText: RichText(
              text: TextSpan(
                text: 'You have',
                style: TextStyle(
                    fontSize: 12, color: Colors.white.withOpacity(0.5)),
                children: [
                  TextSpan(
                    text: ' 14 days ',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  TextSpan(
                    text: 'left to change your requested advance',
                    style: TextStyle(
                        fontSize: 12, color: Colors.white.withOpacity(0.5)),
                  )
                ],
              ),
            ),
            titleWidget: SizedBox(
              height: 50,
              child: Stack(
                children: [
                  SizedBox(
                    width: 145,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: RichText(
                        text: const TextSpan(
                          text: 'DECOR\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                          children: [
                            TextSpan(
                              text: '                 Live beautiful',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: -16,
                    left: 8,
                    child: Text(
                      'D',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.7)),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(2),
                      child: Text(
                        'R',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ActionButton(
            title: 'Request Activity',
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
          const SizedBox(height: 20),

          // Improve your finance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Improve Your Finance',
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ],
          ),
          SizedBox(height: 10),
          const Text(
            'Complete these steps to level-up your finances',
            style: TextStyle(color: AppColors.secondaryTextColor),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return articleCard(
                    title: 'Home owner or renting?',
                    imagePath: 'assets/images/finance.jpeg',
                    onPressed: () {});
              },
            ),
          ),
          SizedBox(height: 20),

          // Helpful articles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Helpful Articles',
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ],
          ),
          SizedBox(height: 10),
          const Text(
            'Get helpful tips and info to boost your financial health',
            style: TextStyle(color: AppColors.secondaryTextColor),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return articleCard(
                  title: 'About Saathi',
                  imagePath: 'assets/images/saathi.png',
                  onPressed: () {
                    showArticleModalBottomSheet(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget articleCard(
      {required String title,
      required String imagePath,
      required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 140,
        width: 180,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                imagePath,
              ),
              fit: BoxFit.fill,
            ),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Container(),
            Positioned(
              bottom: 10,
              left: 10,
              child: SizedBox(
                width: 120,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showArticleModalBottomSheet(BuildContext context) {
  saathiModalBottomSheet(context,
      bottomSheetHeight: MediaQuery.of(context).size.height * 0.85,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'About Saathi',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10),
            Text(
              ''
              'Saathi means ‘Partner/Coach/Advisor’ and we want to be a financial partner to customers, 50% of who are living paycheck to paycheck in India and just help them make the step up from survival to a more balanced financial health. Sorting out financial issues does result in taking away stress, improving focus and showing that a company cares about it’s workforce in every way. We hope you will partner with us to bring this vision to others.\n'
              'Saathi are on a mission to improve peoples financial health by bringing helpful products into their lives from earned salary access to rewarding savings. Saathi is currently available in India.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ));
}
