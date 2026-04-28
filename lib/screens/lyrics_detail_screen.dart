import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../providers/favorites_provider.dart';

class LyricsDetailScreen extends StatefulWidget {
  final String docId;
  final String title;
  final String lyrics;
  final String? categoryName;

  const LyricsDetailScreen({
    super.key,
    required this.docId,
    required this.title,
    required this.lyrics,
    this.categoryName,
  });

  @override
  State<LyricsDetailScreen> createState() => _LyricsDetailScreenState();
}

class _LyricsDetailScreenState extends State<LyricsDetailScreen> {
  double _fontSize = 18.0;

  @override
  void initState() {
    super.initState();
    // Keep screen on when viewing lyrics
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    // Release wakelock when leaving the screen
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.text_decrease_rounded),
            tooltip: 'Decrease font size',
            onPressed: () {
              setState(() {
                if (_fontSize > 12) _fontSize -= 2;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.text_increase_rounded),
            tooltip: 'Increase font size',
            onPressed: () {
              setState(() {
                if (_fontSize < 40) _fontSize += 2;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.categoryName != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.categoryName!,
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            Text(
              widget.lyrics,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: _fontSize,
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
