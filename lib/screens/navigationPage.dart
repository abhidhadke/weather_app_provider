import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:weather_app_provider/screens/homepage.dart';
import 'package:weather_app_provider/screens/search.dart';

class MyNavPage extends StatefulWidget {
  const MyNavPage({Key? key}) : super(key: key);

  @override
  State<MyNavPage> createState() => _MyNavPageState();
}

class _MyNavPageState extends State<MyNavPage> with SingleTickerProviderStateMixin {

  late int currentPage;
  late TabController tabController;
  final List<Color> colors = [
    Colors.blue,
    Colors.pink
  ];


  @override
  void initState() {
    // TODO: implement initState
    currentPage = 0;
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(
          () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return MediaQuery(
       data: queryData.copyWith(
    size: Size(
    queryData.size.width,
      queryData.size.height + queryData.padding.bottom,
    ),
    ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: BottomBar(
          fit: StackFit.expand,
          borderRadius: BorderRadius.circular(50),
          width: MediaQuery.of(context).size.width * 0.35,
          barColor: Colors.black45,
          start: 1,
          end: 0,
          bottom: 10,
          reverse: false,
          scrollOpposite: false,
          alignment: Alignment.bottomCenter,
          iconHeight: 35,
          iconWidth: 35,
          curve: Curves.decelerate,
          showIcon: false,
          body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
             Homepage(),
             Search()
            ]
          ),
          child: TabBar(
              indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 6),
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(
                  color: (currentPage == 0) ? colors[0] : colors[1],
                  width: 2,
                ),
                insets: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              ),
              controller: tabController,
              splashBorderRadius: BorderRadius.circular(50),
              dividerColor: Colors.transparent,
              tabs: [
                SizedBox(
                  height: 50,
                  width: 20,
                  child: Center(
                      child: Icon(
                        Icons.home,
                        color: colors[0],
                      )),
                ),
                SizedBox(
                  height: 50,
                  width: 20,
                  child: Center(
                      child: Icon(
                        Icons.search,
                        color: colors[1],
                      )),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
