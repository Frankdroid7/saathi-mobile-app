import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

String formatAmount(double amount){
  final formatCurrency = NumberFormat.simpleCurrency(
      locale: Platform.localeName, name: 'INR');

  return formatCurrency.format(amount);
}
