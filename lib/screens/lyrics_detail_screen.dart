import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../services/ad_service.dart';

class LyricsDetailScreen extends StatefulWidget {
  final List<QueryDocumentSnapshot> songs;
  final int initialIndex;

  const LyricsDetailScreen({
    super.key,
    required this.songs,
    required this.initialIndex,
  });

  @override
  State<LyricsDetailScreen> createState() => _LyricsDetailScreenState();
}

class _LyricsDetailScreenState extends State<LyricsDetailScreen> {
  double _fontSize = 18.0;
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    // Keep screen on when viewing lyrics
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // Release wakelock when leaving the screen
    WakelockPlus.disable();
    // Handle interstitial logic on exit
    AdService.handleDetailScreenExit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (_widgetData(_currentIndex))['title'] ?? 'Lyrics',
        ),
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
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.songs.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final data = _widgetData(index);
                final lyrics = data['lyrics'] ?? '';
                final categoryName = data['categoryName'];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (categoryName != null)
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
                              categoryName,
                              style: TextStyle(
                                color: theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      Text(
                        lyrics,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.8,
                          fontSize: _fontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                );
              },
            ),
          ),
          ListenableBuilder(
            listenable: AdService.instance,
            builder: (context, child) {
              if (!AdService.isInitialized) return const SizedBox.shrink();
              return SafeArea(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: UnityBannerAd(
                    placementId: AdService.bannerAdUnitId,
                    size: BannerSize.standard,
                    onLoad: (placementId) => print('Banner loaded: $placementId'),
                    onClick: (placementId) => print('Banner clicked: $placementId'),
                    onFailed: (placementId, error, message) => 
                        print('Banner failed: $placementId, [$error] $message'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _widgetData(int index) {
    return widget.songs[index].data() as Map<String, dynamic>;
  }
}
