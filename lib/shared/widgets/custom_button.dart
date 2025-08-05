import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = !isEnabled || isLoading;

    Widget button;

    switch (type) {
      case ButtonType.primary:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height ?? 48),
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppConstants.mediumSpacing,
                  vertical: AppConstants.smallSpacing,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppConstants.mediumRadius,
              ),
            ),
          ),
          child: _buildContent(theme),
        );
        break;

      case ButtonType.secondary:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondary,
            foregroundColor: theme.colorScheme.onSecondary,
            minimumSize: Size(width ?? double.infinity, height ?? 48),
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppConstants.mediumSpacing,
                  vertical: AppConstants.smallSpacing,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppConstants.mediumRadius,
              ),
            ),
          ),
          child: _buildContent(theme),
        );
        break;

      case ButtonType.outline:
        button = OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height ?? 48),
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppConstants.mediumSpacing,
                  vertical: AppConstants.smallSpacing,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppConstants.mediumRadius,
              ),
            ),
          ),
          child: _buildContent(theme),
        );
        break;

      case ButtonType.text:
        button = TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size(width ?? 0, height ?? 48),
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: AppConstants.mediumSpacing,
                  vertical: AppConstants.smallSpacing,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppConstants.mediumRadius,
              ),
            ),
          ),
          child: _buildContent(theme),
        );
        break;
    }

    return button;
  }

  Widget _buildContent(ThemeData theme) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == ButtonType.primary
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.primary,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: AppConstants.smallSpacing),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}
