import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarScreen extends StatefulWidget{
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
    return _tabBar();
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
      onTap: (index) => {
        setState(() {
          nowIndex = this.tabController.index;
          notifyListeners();
        })
      }
    );
  }
}

class PaymentInformation extends StatefulWidget{
  PaymentInformation({super.key});

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation>{

  TabBarScreen tabBarScreen = TabBarScreen();

  @override
  void initState(){
    super.initState();
  }

  // 하나의 build 함수 내부에서 Provider를 소비, 생산을 동시에 하는 경우 Consumer 메서드 사용
  // 아닌 경우 context.read, watch<T>().Func 패턴 사용
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        tabBarScreen,
        SizedBox(height: 40),
        PaymentPresentation(tabBarScreen: tabBarScreen)
      ],
    );
  }
}

class PaymentPresentation extends StatefulWidget{

  TabBarScreen tabBarScreen = TabBarScreen();
  PaymentPresentation({super.key, required TabBarScreen tabBarScreen}){
    this.tabBarScreen = tabBarScreen;
  }

  @override
  State<PaymentPresentation> createState() => _PaymentPresentationState();
}

class _PaymentPresentationState extends State<PaymentPresentation>{

  TabBarScreen tabBarScreen = TabBarScreen();

  Widget build(BuildContext context){

    this.tabBarScreen = widget.tabBarScreen;

    return ChangeNotifierProvider(
      create: (_) => tabBarScreen.tabBarScreenState,
      child: Consumer<_TabBarScreenState>(
          builder: (context, tabscr, child){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (tabscr.nowIndex == 0)
                  Text('2025년 8월 9일의 소비액은 얼마입니다.')
                else if (tabscr.nowIndex == 1)
                  Text('2025년 7월 9일 부터 8월 9일 까지의 소비액은 얼마입니다.')
                else
                  Text('2024년 8월 9일 부터 2025년 8월 9일 까지의 소비액은 얼마입니다.'),
                SizedBox(height: 40),
                Container(
                  width: 300,
                  height: 300,
                  padding: EdgeInsets.all(20),
                  color: Colors.greenAccent,
                ),
                Divider(height: 2, color: Colors.black)
              ],
            );
          }
      ),
    );
  }
}