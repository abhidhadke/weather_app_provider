import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/screens/components/appBar.dart';
import 'package:weather_app_provider/screens/navigationPage.dart';

import 'components/changeBG.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  BannerAd? _bannerAd;

  //TODO: change this Id to my ID
  final adUnitId = 'ca-app-pub-3940256099942544/2934735716';

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('Ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  @override
  void initState() {
    // TODO: implement initState
    loadAd();
    super.initState();
    controller.text = '';
    final locProvider = Provider.of<SearchLocation>(context, listen: false);
    locProvider.locData.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchLocation>(context, listen: false);
    final locProvider = Provider.of<ApiResponse>(context, listen: false);
    debugPrint('build');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(size),
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            changeBg(locProvider.id, locProvider.icon),
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black12),
          ),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      height: 50,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            autofocus: true,
                            controller: controller,
                            style: GoogleFonts.poppins(color: Colors.white70),
                            decoration: InputDecoration(
                              hintText: 'search city',
                              hintStyle: GoogleFonts.poppins(
                                  color: Colors.white54,
                                  fontStyle: FontStyle.italic),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onFieldSubmitted: (String? name) async {
                              debugPrint(name);
                              //await instance.getLoc(name!);
                              searchProvider.getLoc(name!);
                            },
                          )),
                          IconButton(
                            icon: const Icon(Icons.search_rounded),
                            color: Colors.white70,
                            onPressed: () async {
                              debugPrint(controller.text);
                              //await instance.getLoc(controller.text);
                              searchProvider.getLoc(controller.text);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Consumer<SearchLocation>(
                        builder: (context, value, child) {
                          debugPrint('inside consumer');
                          //debugPrint('${value.locData.length}');
                          return ListView.builder(
                              itemCount: value.locData.length,
                              itemBuilder: (context, index) {
                                debugPrint('${value.locData.length}');
                                Map<String, dynamic> cityCard =
                                    value.locData[index];
                                return Card(
                                  //color: const Color(0xffdbdc54),
                                  elevation: 2,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10.0),
                                    onTap: () async {
                                      final newLocation =
                                          Provider.of<ApiResponse>(context,
                                              listen: false);
                                      //final newTime = Provider.of<DateProvider>(context, listen: false);
                                      await newLocation.getLocation(
                                          cityCard['lat'].toString(),
                                          cityCard['lon'].toString());
                                      debugPrint('${newLocation.timezone}');
                                      _pushtoNewScreen(newLocation.timezone);
                                      debugPrint('tapped');
                                    },
                                    child: ListTile(
                                      title: Text(
                                        '${cityCard['name']}, ${cityCard['country']}',
                                        style: GoogleFonts.poppins(
                                            fontSize: size.width * 0.05),
                                      ),
                                      subtitle: Text(
                                        cityCard['state'] ?? '',
                                        style: GoogleFonts.poppins(
                                            fontSize: size.width * 0.038),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _pushtoNewScreen(int timezone) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => MyNavPage(timezone: timezone)),
        (route) => false);
  }
}
