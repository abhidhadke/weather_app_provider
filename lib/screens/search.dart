import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:weather_app_provider/constants.dart';
import 'package:weather_app_provider/network/api_response.dart';
import 'package:weather_app_provider/screens/components/appBar.dart';
import 'package:weather_app_provider/screens/components/interstitial_ad.dart';
import 'package:weather_app_provider/screens/navigationPage.dart';
import 'components/changeBG.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;



  @override
  void initState() {
    super.initState();
    controller.text = '';
    final locProvider = Provider.of<SearchLocation>(context, listen: false);
    locProvider.locData.clear();
  }


  @override
  void dispose() {
    debugPrint('Disposed search page');
    super.dispose();
  }

  UnityBannerAd buildUnityBannerSearchAd() {
    return UnityBannerAd(
      placementId: searchAdId,
      onLoad: (placementId) => debugPrint('Banner loaded: $placementId'),
      onClick: (placementId) => debugPrint('Banner clicked: $placementId'),
      onFailed: (placementId, error, message) => debugPrint('Banner Ad $placementId failed: $error $message'),
    );
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: buildUnityBannerSearchAd().size.height.toDouble(),
                      width: buildUnityBannerSearchAd().size.width.toDouble(),
                      child: buildUnityBannerSearchAd(),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            border: Border.all(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: TextFormField(
                              autofocus: true,
                              controller: controller,
                              style: GoogleFonts.poppins(
                                  fontSize: size.height * 0.02,
                                  color: Colors.white70),
                              decoration: InputDecoration(
                                hintText: 'search city',
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: size.height * 0.02,
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
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: IconButton(
                                icon: const Icon(Icons.search_rounded),
                                color: Colors.white70,
                                onPressed: () async {
                                  debugPrint(controller.text);
                                  //await instance.getLoc(controller.text);
                                  searchProvider.getLoc(controller.text);
                                },
                              ),
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
                            return value.listLoading
                                ? const Center(
                              child: CircularProgressIndicator(),
                            )
                                : ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                itemCount: value.locData.length,
                                itemBuilder: (context, index) {
                                  debugPrint('${value.locData.length}');
                                  Map<String, dynamic> cityCard =
                                  value.locData[index];
                                  return Card(
                                    //color: const Color(0xffdbdc54),
                                    elevation: 2,
                                    child: InkWell(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      onTap: () async {
                                        value.setLoading(true);
                                        final newLocation =
                                        Provider.of<ApiResponse>(
                                            context,
                                            listen: false);
                                        int res =
                                        await newLocation.getLocation(
                                            cityCard['lat']
                                                .toString(),
                                            cityCard['lon']
                                                .toString());
                                        if (res == 1) {
                                          value.setLoading(false);
                                          _pushtoNewScreen(newLocation.timezone);
                                          await showAdVideo();
                                        } else {
                                          value.setLoading(false);
                                        }
                                      },
                                      child: ListTile(
                                        title: Text(
                                          '${cityCard['name']}, ${cityCard['country']}',
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              size.width * 0.05),
                                        ),
                                        subtitle: Text(
                                          cityCard['state'] ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              size.width * 0.038),
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
            ),
          ),
          Consumer<SearchLocation>(builder: (context, value, child) {
            return Visibility(
              visible: value.loading,
              child: Container(
                color: Colors.black54,
              ),
            );
          }),
          Consumer<SearchLocation>(builder: (context, value, child) {
            return Visibility(
              visible: value.loading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          })
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
