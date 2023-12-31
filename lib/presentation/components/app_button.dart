import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kawanlama/domain/constant/app_colors.dart';
import 'package:kawanlama/domain/constant/app_text_styles.dart';

class AppButton {
  static Widget defaults({
    required String title,
    VoidCallback? onPressed,
    String? assets,
    Color? color,
    EdgeInsets? padding,
    double? textSize,
    double? radius,
    bool enabled = true,
  }) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),
          backgroundColor: color ?? AppColors.primary.withOpacity(0.6),
          elevation: 0,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
      child: Row(
        children: [
          if (assets != null) SvgPicture.asset(assets),
          Expanded(
            child: Text(title,
                textAlign: TextAlign.center,
                style: textSize != null ? AppStyles.textXs.semiBold.white.copyWith(fontSize: textSize) : AppStyles.textMd.semiBold.white),
          ),
        ],
      ),
    );
  }

  static Widget inverted({
    required String title,
    VoidCallback? onPressed,
    String? assets,
    Color? color,
    EdgeInsets? padding,
    double? textSize,
    bool enabled = true,
  }) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: color ?? AppColors.white,
          elevation: 0,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
      child: Row(
        children: [
          if (assets != null) SvgPicture.asset(assets, color: AppColors.primary, width: textSize, height: textSize),
          Expanded(
            child: Text(title,
                textAlign: TextAlign.center,
                style: textSize != null ? AppStyles.textXs.semiBold.primary.copyWith(fontSize: textSize) : AppStyles.textMd.semiBold.primary),
          ),
        ],
      ),
    );
  }

  static Widget text({
    required String title,
    VoidCallback? onPressed,
    String? assets,
    Color? color,
    EdgeInsets? padding,
    double? textSize,
    double? radius,
    bool enabled = true,
  }) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
      child: Row(
        children: [
          if (assets != null) SvgPicture.asset(assets),
          Expanded(
            child: Text(title,
                textAlign: TextAlign.center, style: textSize != null ? AppStyles.textXs.semiBold.copyWith(fontSize: textSize) : AppStyles.textMd.semiBold),
          ),
        ],
      ),
    );
  }
}
