import 'package:flutter/foundation.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class AdService extends ChangeNotifier {
  static final AdService instance = AdService._internal();
  AdService._internal();

  static const String gameId = '6102935';
  static const String bannerAdUnitId = 'Banner_Android';
  static const String interstitialAdUnitId = 'Interstitial_Android';

  static bool isInitialized = false;
  static int _detailExitCount = 0;

  static void init() {
    UnityAds.init(
      gameId: gameId,
      testMode: false,
      onComplete: () {
        isInitialized = true;
        print('Unity Ads Initialization Complete');
        instance.notifyListeners();
        loadInterstitial();
      },
      onFailed: (error, message) {
        isInitialized = false;
        print('Unity Ads Initialization Failed: [$error] $message');
        instance.notifyListeners();
      },
    );
  }

  static void loadInterstitial() {
    UnityAds.load(
      placementId: interstitialAdUnitId,
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) {
        print('Load Failed $placementId: [$error] $message');
        // Retry loading after a delay to handle temporary network issues
        Future.delayed(const Duration(seconds: 10), () {
          if (isInitialized) {
            print('Retrying to load interstitial...');
            loadInterstitial();
          }
        });
      },
    );
  }

  static void showInterstitial() {
    UnityAds.showVideoAd(
      placementId: interstitialAdUnitId,
      onComplete: (placementId) {
        print('Video Ad Complete $placementId');
        loadInterstitial(); // Load next one
      },
      onFailed: (placementId, error, message) => print('Video Ad Failed $placementId: [$error] $message'),
      onStart: (placementId) => print('Video Ad Start $placementId'),
      onClick: (placementId) => print('Video Ad Click $placementId'),
      onSkipped: (placementId) {
        print('Video Ad Skipped $placementId');
        loadInterstitial(); // Load next one
      },
    );
  }

  static void handleDetailScreenExit() {
    _detailExitCount++;
    print('Detail screen exit count: $_detailExitCount');
    if (_detailExitCount % 2 == 0) {
      showInterstitial();
    }
  }
}
