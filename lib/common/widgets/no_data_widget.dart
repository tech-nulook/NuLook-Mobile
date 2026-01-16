
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? imageAsset;
  final IconData? icon;
  final String buttonText;
  final VoidCallback? onRefresh;

  const NoDataWidget({
    super.key,
    this.title = 'No Data Found',
    this.description = 'We couldn’t find any data at the moment.',
    this.imageAsset,
    this.icon = Icons.error_outline,
    this.buttonText = 'Refresh',
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Image or Icon
            if (imageAsset != null)
              Image.asset(
                imageAsset!,
                height: 120,
                fit: BoxFit.contain,
              )
            else
              Icon(
                icon,
                size: 50,
                color: Colors.redAccent.shade100
              ),

            const SizedBox(height: 16),

            /// Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            /// Refresh Button
            if (onRefresh != null)
              ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: Text(buttonText),
              ),
          ],
        ),
      ),
    );
  }
}