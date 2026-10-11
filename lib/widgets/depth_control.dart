import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_controller.dart';
import '../theme/app_theme.dart';

class DepthControl extends StatelessWidget {
  const DepthControl({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final chrome = context.watchThemeChrome(context);
    const depths = ['beginner', 'intermediate', 'advanced'];
    const labels = ['Beginner', 'Intermediate', 'Advanced'];
    final caption = switch (settings.depth) {
      'beginner' => 'Mode: Beginner · shells, everyday state, uses.',
      'advanced' => 'Mode: Advanced · quantum metrics, lines, isotopes.',
      _ => 'Mode: Intermediate · mass, shells, oxidation. Switch to Beginner or Advanced.',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: chrome.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: chrome.border.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              for (var i = 0; i < depths.length; i++)
                Expanded(
                  child: InkWell(
                    onTap: () => settings.setDepth(depths[i]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: settings.depth == depths[i]
                            ? chrome.action.withValues(alpha: 0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        labels[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: settings.depth == depths[i]
                              ? chrome.action
                              : chrome.muted,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(caption, style: TextStyle(color: chrome.muted, fontSize: 12)),
      ],
    );
  }
}

extension on BuildContext {
  ChromePalette watchThemeChrome(BuildContext context) {
    // Avoid circular import by reading Theme.
    final cs = Theme.of(this).colorScheme;
    return ChromePalette(
      canvas: Theme.of(this).scaffoldBackgroundColor,
      surface: cs.surface,
      raised: cs.surface,
      border: cs.outline,
      text: cs.onSurface,
      muted: cs.onSurface.withValues(alpha: 0.7),
      faint: cs.onSurface.withValues(alpha: 0.5),
      action: cs.primary,
      onAction: cs.onPrimary,
    );
  }
}
