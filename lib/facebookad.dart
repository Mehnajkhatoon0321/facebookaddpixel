import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:facebookaddpixel/second.dart';
import 'package:flutter/material.dart';

class FacebookAds extends StatefulWidget {
  @override
  _FacebookAdsState createState() => _FacebookAdsState();
}

class _FacebookAdsState extends State<FacebookAds> {
  bool _isInterstitialAdLoaded = true;

  @override
  void initState() {
    super.initState();
    FacebookAudienceNetwork.init(
      testingId: "74416a93-46a7-4566-97ef-ff1c5d9589a3",
    );

    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#299486252083346_299911042040867",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: <Widget>[

          _buildListTile("One-line with both widgets"),
          _nativeAd(),


          _buildListTile("One-line with both widgets"),
          _nativeBannerAd(),
          _buildListTile("One-line with both widgets"),
          _buildListTile("One-line with both widgets"),
          _nativeBannerAd(),
          _buildListTile("One-line with both widgets", showInterstitial: true),
        ]),
      ),
    );
  }

  Widget _buildListTile(String title, {bool showInterstitial = false}) {
    return ListTile(
      leading: FlutterLogo(),
      title: Text(title),
      trailing: Icon(Icons.favorite_border),
      onTap: () {
        if (showInterstitial) {
          _showInterstitialAd();
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
      },
    );
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstitial Ad not yet loaded!");
  }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#299486252083346_299911602040811",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#299486252083346_299911465374158",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }
}
