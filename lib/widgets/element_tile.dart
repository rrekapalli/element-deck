import 'package:flutter/material.dart';

import '../models/catalog.dart';
import '../theme/app_theme.dart';
import '../theme/element_spectrum.dart';

class ElementRowCard extends StatelessWidget {
  const ElementRowCard({
    super.key,
    required this.element,
    required this.selected,
    required this.onTap,
  });

  final ElementRecord element;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = ElementSpectrum.of(element.categoryId);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: selected ? accent.withValues(alpha: 0.12) : null,
      child: ListTile(
        onTap: onTap,
        dense: true,
        leading: SizedBox(
          width: 44,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${element.z}', style: Mono.of(context, size: 10, color: Theme.of(context).hintColor)),
              Text(
                element.symbol,
                style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
        ),
        title: Text(element.name),
        subtitle: Text(
          '${element.categoryLabel} · ${element.standardState}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '${element.atomicWeight}',
          style: Mono.of(context, size: 11, color: Theme.of(context).hintColor),
        ),
      ),
    );
  }
}
