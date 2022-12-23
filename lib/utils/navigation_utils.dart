import 'package:flutter/material.dart';

navigateToScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

popScreen(BuildContext context) {
  Navigator.of(context).pop();
}
