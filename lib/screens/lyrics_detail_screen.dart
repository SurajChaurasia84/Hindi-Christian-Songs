import 'package:flutter/material.dart';

class LyricsDetailScreen extends StatelessWidget {
  final String title;
  final String lyrics;
  final String? categoryName;

  const LyricsDetailScreen({
    super.key,
    required this.title,
    required this.lyrics,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () {
              // TODO: Implement favorites
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to favorites')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (categoryName != null)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  categoryName!,
                  style: TextStyle(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              lyrics,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
