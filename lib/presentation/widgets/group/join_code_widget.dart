// File: lib/presentation/widgets/group/join_code_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoinCodeWidget extends StatelessWidget {
  final String joinCode;
  final VoidCallback onShare;
  final VoidCallback? onRegenerate;

  const JoinCodeWidget({
    Key? key,
    required this.joinCode,
    required this.onShare,
    this.onRegenerate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Join Code',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                joinCode,
                style: theme.textTheme.headlineMedium?.copyWith(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.copy),
                tooltip: 'Copy to clipboard',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: joinCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Join code copied to clipboard')),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.share),
            label: const Text('Share Join Code'),
            onPressed: onShare,
          ),
          if (onRegenerate != null) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Regenerate Code'),
              onPressed: onRegenerate,
            ),
          ],
        ],
      ),
    );
  }
}