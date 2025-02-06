import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final double? minWidth;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final Color? buttonColor;
  final bool isDisabled;
  final bool? isFilterButtons;

  const PrimaryButton({
    super.key,
    this.leadingIcon,
    this.leadingIconColor,
    required this.label,
    required this.onPressed,
    this.padding,
    this.minWidth,
    this.buttonColor,
    this.isDisabled = false,
    this.isFilterButtons,
  });

  @override
  Widget build(BuildContext context) {
    const Color defaultButtonColor = Color(0xFF2196F3);
    final Color defaultDisabledColor = Colors.grey.shade300;
    const Color defaultTextColor = Colors.white;
    final Color disabledTextColor = Colors.grey.shade500;

    return MaterialButton(
      onPressed: isDisabled ? null : onPressed,
      minWidth: minWidth,
      color:
      isDisabled ? defaultDisabledColor : buttonColor ?? defaultButtonColor,
      disabledColor: defaultDisabledColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: leadingIcon != null ? 36 : 48,
            vertical: isFilterButtons == true ? 12 : 18,
          ),
      elevation: 0, // Flat design
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              size: 18,
              color: isDisabled
                  ? disabledTextColor
                  : leadingIconColor ?? defaultTextColor,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDisabled
                  ? disabledTextColor
                  : leadingIconColor ?? defaultTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
