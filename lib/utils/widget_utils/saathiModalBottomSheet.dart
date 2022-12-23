import 'package:flutter/material.dart';

Future<T?> saathiModalBottomSheet<T>(BuildContext context,
    {double? bottomSheetHeight, required Widget child}) {
  bottomSheetHeight ??= MediaQuery.of(context).size.height * 0.8;

  return showModalBottomSheet<T?>(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    builder: (context) {
      return SizedBox(
        height: bottomSheetHeight,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      );
    },
  );
}
