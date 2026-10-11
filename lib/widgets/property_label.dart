import 'package:flutter/material.dart';

import '../guides/property_guide_page.dart';

/// A Data-tab label. Double-tap, or double-click, opens its reference article.
///
/// A single tap does nothing, so scrolling the table does not leave the page.
/// Screen-reader activation opens the article directly.
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
      hint: 'Double tap to open the reference article',
      onTap: () => openPropertyGuide(context, guideId),
      child: Tooltip(
        message: 'Double-tap to read about $label',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onDoubleTap: () => openPropertyGuide(context, guideId),
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
