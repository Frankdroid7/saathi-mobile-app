import 'package:flutter/material.dart';
import 'package:saathi/features/goal/presentation/goals_pageview.dart';
import 'package:saathi/features/invest/presentation/invest_pageview.dart';
import 'package:saathi/features/save/presentation/save_pageview.dart';
import 'package:saathi/styles.dart';

import 'features/earn/presentation/earn_pageview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageViewIndex = 0;
  List<String> tabText = ['Earn', 'Save', 'Invest', 'Goals'];
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Saathi',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryTextColor.withOpacity(0.5),
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    children: const [
                      Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: AppColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const ProfilePictureWidget(),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 20,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: tabText.asMap().entries.map((entry) {
                      int index = entry.key;
                      String value = entry.value;

                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: index == currentPageViewIndex
                                  ? AppColors.primaryTextColor
                                  : AppColors.secondaryTextColor,
                            ),
                          ),
                        ),
                        onTap: () => animateToPage(index),
                      );
                    }).toList()),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPageViewIndex = index;
                    });
                  },
                  children: const [
                    EarnPageView(),
                    SavePageView(),
                    InvestPageView(),
                    GoalsPageView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  animateToPage(int page) {
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey,
                Colors.grey,
                Colors.grey,
                Colors.grey,
                Colors.grey,
                Colors.grey,
                Colors.grey,
                Colors.red,
                Colors.red,
                Colors.red,
                Colors.red,
                Colors.red,
                Colors.red,
                Colors.blue,
                Colors.blue,
                Colors.blue,
                Colors.blue,
                Colors.blue,
                Colors.blue,
                Colors.blue,
                Colors.blue,
                Colors.green,
                Colors.green,
                Colors.green,
                Colors.green,
              ])),
      child: Container(
        width: 70,
        height: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              width: 3,
              color: Colors.white,
            ),
            image: const DecorationImage(
                image: NetworkImage(
                    'https://image.shutterstock.com/mosaic_250/2780032/1194497251/stock-photo-portrait-of-smiling-red-haired-millennial-man-looking-at-camera-sitting-in-caf-or-coffeeshop-1194497251.jpg'))),
        alignment: Alignment.center,
        // child: const Text('Linear Gradient'),
      ),
    );
  }
}
