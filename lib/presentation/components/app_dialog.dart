import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kawanlama/domain/constant/app_colors.dart';

class AppDialog {
  static Future showInfoInMd(BuildContext context, {required String info}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 8),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: AppColors.primary.shade50,
                  height: kToolbarHeight,
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: MarkdownBody(data: info),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
