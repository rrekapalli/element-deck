import 'package:flutter/material.dart';

import '../guides/property_guide_page.dart';

/// A Data-tab label. A tap, or a click, opens its reference article.
class PropertyLabel extends StatelessWidget {
  const PropertyLabel({
    super.key,
    required this.label,
    required this.guideId,
    this.style,
  });

  final String label;
  final String guideId;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final action = theme.colorScheme.primary;
    final base =
        style ??
        theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
        );
    return Semantics(
      button: true,
      label: label,
      hint: 'Opens the reference article',
      onTap: () => openPropertyGuide(context, guideId),
      child: Tooltip(
        message: 'Read about $label',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => openPropertyGuide(context, guideId),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                label,
                style: base?.copyWith(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                  decorationColor: action.withValues(alpha: 0.85),
                  decorationThickness: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
