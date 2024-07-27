

class AdState {
  // Future<InitializationStatus> initialization;

  // static AppOpenAd? appOpenAd;
  // static bool isShowingAd = false;
  //
  // AdState(this.initialization);
  //
  // static String get nativeVideoId => Platform.isAndroid
  //     ? 'ca-app-pub-6237326926737313/2966617373'
  //     : 'ca-app-pub-6237326926737313/2966617373';
  //
  // static void nativeAd() async {
  //   var googleChannel = await MethodPlugin.isGoogleChannel();
  //   if (!googleChannel) {
  //     return;
  //   }
  //   // var testDeviceIds = [
  //   //   "D55AD4018A1ACD9E4DA3D1DFCE81D831",
  //   //   "29AB608989C676D10147222ADEE2CCFC",
  //   //   "C66F0051F5259F4A770B541B5384C60B"
  //   // ];
  //   // var configuration = RequestConfiguration(testDeviceIds: testDeviceIds);
  //   // MobileAds.instance.updateRequestConfiguration(configuration);
  //   AppOpenAd.load(
  //     adUnitId: nativeVideoId,
  //     orientation: AppOpenAd.orientationPortrait,
  //     request: const AdRequest(),
  //     adLoadCallback: AppOpenAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         appOpenAd = ad;
  //         showAd();
  //       },
  //       onAdFailedToLoad: (error) {
  //         print('AppOpenAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }
  //
  // static void showAd() {
  //   if (appOpenAd == null) {
  //     nativeAd();
  //     return;
  //   }
  //   if (isShowingAd) {
  //     return;
  //   }
  //   appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (ad) {
  //       isShowingAd = true;
  //     },
  //     onAdFailedToShowFullScreenContent: (ad, error) {
  //       isShowingAd = false;
  //       ad.dispose();
  //       appOpenAd = null;
  //     },
  //     onAdDismissedFullScreenContent: (ad) {
  //       isShowingAd = false;
  //       ad.dispose();
  //       appOpenAd = null;
  //       // loadAd();
  //     },
  //   );
  //   appOpenAd!.show();
  // }
}
