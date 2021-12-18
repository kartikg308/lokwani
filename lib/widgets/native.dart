// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class NativeAds extends StatefulWidget {
  const NativeAds({Key? key}) : super(key: key);

  @override
  _NativeAdsState createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds>
    with AutomaticKeepAliveClientMixin {
  final controller = NativeAdController();

  @override
  void initState() {
    super.initState();
    controller.load(keywords: [
      'car',
      'sport',
      // 'fashion',
      // 'watches',
      // 'shoes',
      // 'games',
      // 'devices'
    ]);
    controller.onEvent.listen((e) {
      final event = e.keys.first;
      switch (event) {
        case NativeAdEvent.loading:
          print('loading');
          break;
        case NativeAdEvent.loaded:
          print('loaded');
          break;
        case NativeAdEvent.loadFailed:
          final errorCode = e.values.first;
          print('loadFailed $errorCode');
          break;
        case NativeAdEvent.muted:
          print('muted');
          break;
        case NativeAdEvent.undefined:
          print('undefined ad');
          break;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NativeAd(
      height: MediaQuery.of(context).size.height - 400,
      // unitId: 'ca-app-pub-5001643996279117/9647512548',
      unitId: MobileAds.appOpenAdTestUnitId,
      loading: const Text('loading'),
      error: const Text('Ads failed to load'),
      icon: AdImageView(size: 30),
      headline: AdTextView(
        padding: const EdgeInsets.only(bottom: 10),
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        maxLines: 1,
      ),
      media: AdMediaView(
        height: MediaQuery.of(context).size.height / 3.5,
        width: MATCH_PARENT,
      ),
      attribution: AdTextView(
        width: WRAP_CONTENT,
        text: 'Ad',
        decoration: AdDecoration(
            border: const BorderSide(color: Colors.green, width: 2),
            borderRadius: AdBorderRadius.all(16)),
        style: const TextStyle(color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      ),
      button: AdButtonView(
        decoration: AdDecoration(backgroundColor: Colors.blue),
        elevation: 18,
        textStyle: const TextStyle(color: Colors.white),
        height: MATCH_PARENT,
      ),
      buildLayout: fullBuilder,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

AdLayoutBuilder get fullBuilder => (ratingBar, media, icon, headline,
        advertiser, body, price, store, attribuition, button) {
      return AdLinearLayout(
        decoration: AdDecoration(
          backgroundColor: Colors.black54,
        ),
        padding: const EdgeInsets.all(10),
        // The first linear layout width needs to be extended to the
        // parents height, otherwise the children won't fit good
        width: MATCH_PARENT,

        children: [
          media,
          AdLinearLayout(
            children: [
              icon,
              AdLinearLayout(children: [
                headline,
                AdLinearLayout(
                  children: [attribuition, advertiser, ratingBar],
                  orientation: HORIZONTAL,
                  width: MATCH_PARENT,
                ),
              ], margin: const EdgeInsets.only(left: 4)),
            ],
            gravity: LayoutGravity.center_horizontal,
            width: WRAP_CONTENT,
            orientation: HORIZONTAL,
            margin: const EdgeInsets.only(top: 6),
          ),
          AdLinearLayout(
            children: [button],
            orientation: HORIZONTAL,
          ),
        ],
      );
    };
