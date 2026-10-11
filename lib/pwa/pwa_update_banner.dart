import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pwa_update_service.dart';

/// Bottom strip when a new PWA build is waiting.
class PwaUpdateBanner extends StatelessWidget {
  const PwaUpdateBanner({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();
    return ListenableBuilder(
      listenable: PwaUpdateService.instance,
      builder: (context, _) {
        if (!PwaUpdateService.instance.updateReady) {
          return const SizedBox.shrink();
        }
        final scheme = Theme.of(context).colorScheme;
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: scheme.primary,
            elevation: 8,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'A new version of Element Deck is ready.',
                        style: TextStyle(
                          color: scheme.onPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5,
                          height: 1.25,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: PwaUpdateService.instance.dismiss,
                      style: TextButton.styleFrom(
                        foregroundColor: scheme.onPrimary,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: const Text('Later'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {
                        unawaited(PwaUpdateService.instance.applyUpdate());
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: scheme.onPrimary,
                        foregroundColor: scheme.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        minimumSize: const Size(0, 36),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
