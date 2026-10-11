import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../account/account_controller.dart';
import '../billing/pack_ids.dart';
import '../billing/purchase_service.dart';

class CoursePaywall extends StatelessWidget {
  const CoursePaywall({super.key, required this.depth, this.message});

  final String depth;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final billing = context.watch<PurchaseService>();
    final account = context.watch<AccountController>();
    final id = packIdForDepth(depth);
    final title = packTitles[id] ?? id;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              message ??
                  'This course is a separate pack. Preview elements stay free. Sign in on Android or iOS to buy.',
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: account.user == null
                  ? account.signInGoogle
                  : () => billing.buy(id),
              child: Text(
                account.user == null
                    ? 'Sign in to buy'
                    : 'Buy · ${billing.priceLabel(id)}',
              ),
            ),
            if (billing.message != null) ...[
              const SizedBox(height: 8),
              Text(billing.message!),
            ],
          ],
        ),
      ),
    );
  }
}
