import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  static const _borderRadius = BorderRadius.all(Radius.circular(10));

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: _borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
    final interactive = onTap == null
        ? content
        : InkWell(
            borderRadius: _borderRadius,
            onTap: onTap,
            child: content,
          );
    return Material(
      color: Colors.transparent,
      borderRadius: _borderRadius,
      child: interactive,
    );
  }
}
