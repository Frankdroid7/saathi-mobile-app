import 'package:flutter/material.dart';
import 'package:saathi/styles.dart';

class HeaderCard extends StatelessWidget {
  final Widget bodyWidget;
  final Widget titleWidget;
  final bool onEarnPageView;
  final Widget subtitleText;
  final String actionCardTitle;
  final VoidCallback actionCardOnTap;
  const HeaderCard(
      {Key? key,
      this.onEarnPageView = false,
        required this.bodyWidget,
      required this.actionCardOnTap,
      required this.actionCardTitle,
      required this.subtitleText,
      required this.titleWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 240,
          color: Colors.transparent,
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: InkWell(
            onTap: actionCardOnTap,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: Text(
                    actionCardTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          height: 180,
          child: Card(
            elevation: 10,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        titleWidget,
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: bodyWidget,
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 14, left: 14),
                          child: subtitleText,
                        ),
                      ],
                    ),
                    Container(),
                    onEarnPageView
                        ? Positioned(
                            right: 0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.tertiaryColor,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                  child: Text(
                                    'Pending',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    '1/2 requests',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
