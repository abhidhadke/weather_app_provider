import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/network/api_response.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = '';

  }
  @override
  Widget build(BuildContext context) {
    final locProvider = Provider.of<ApiResponse>(context, listen: false);
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset('assets/rain_day.png', fit: BoxFit.fill, height: double.infinity,width: double.infinity,),
          Container(decoration: const BoxDecoration(color: Colors.black12),),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      height: 50,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                          border: Border.all(
                            color: Colors.black54,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(

                                autofocus: false,
                                controller: controller,
                                style: GoogleFonts.poppins(
                                  color: Colors.white70
                                ),
                                decoration: InputDecoration(
                                  hintText: 'search city',
                                  hintStyle: GoogleFonts.poppins(
                                    color: Colors.white54,
                                    fontStyle: FontStyle.italic
                                  ),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                onFieldSubmitted: (String? name) async {
                                  debugPrint(name);
                                  locProvider.getLoc(name!);
                                },
                              )
                          ),
                           IconButton(
                             icon:const Icon(Icons.search_rounded),
                             color: Colors.white70,
                             onPressed: ()async {
                               debugPrint(controller.text);
                               locProvider.getLoc(controller.text);
                             },)
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Consumer<ApiResponse>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            itemCount: value.locData.length,
                              itemBuilder: (context, index){
                              debugPrint('${value.locData.length}');
                              Map<String,dynamic> cityCard = value.locData[index];
                              return Card(
                                child: ListTile(
                                  title: Text(cityCard['name']),
                                ),
                              );
                              }
                          );
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
}
