import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarScreen extends StatefulWidget with ChangeNotifier{
  TabBarScreen({Key? key}) : super(key: key);
  _TabBarScreenState tabBarScreenState = _TabBarScreenState();

  @override
  State<TabBarScreen> createState() => tabBarScreenState;
}

class _TabBarScreenState extends State<TabBarScreen> with TickerProviderStateMixin, ChangeNotifier{
  int nowIndex = 0;

  late TabController tabController = TabController(
    length: 3,
    vsync: this,
    initialIndex: 0,

    /// 탭 변경 애니메이션 시간
    animationDuration: const Duration(milliseconds: 800),
  );

  void updateIndex(){
    setState(() {
      nowIndex = this.tabController.index;
    });
    notifyListeners();
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _tabBar()
    );
  }
  // TabController -> controller which shows information of tabbar
  Widget _tabBar() {
    return TabBar(
      controller: tabController,
      tabs: const [
        Tab(text: "일별"),
        Tab(text: "월별"),
        Tab(text: "연별"),
      ],
      labelColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(
        fontSize: 16
      ),
      indicatorColor: Colors.black,
      indicatorWeight: 5,
      indicatorSize: TabBarIndicatorSize.tab,
      onTap: (index) => {updateIndex()}
    );
  }
}

class PaymentInformation extends StatefulWidget{
  PaymentInformation({super.key});

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation>{

  @override
  void initState(){
    super.initState();
  }

  TabBarScreen tabBarScreen = TabBarScreen();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        tabBarScreen,
        ChangeNotifierProvider(
          create: (_) => tabBarScreen.tabBarScreenState,
          child: Consumer<_TabBarScreenState>(
            builder: (context, tabbarscreen, child){
              return Text('${tabbarscreen.nowIndex}');
            }
          )
        ),
      ],
    );
  }
}