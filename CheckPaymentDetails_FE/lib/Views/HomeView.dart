import 'package:flutter/material.dart';
import 'package:payment_app/Widgets/appFrame.dart';

class HomeView extends StatelessWidget{
  HomeView(){}

  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  mainAppBar(name: appName),
                  SizedBox(height: 20),
                  Container(
                      height: screenHeight - 210,
                      width: screenWidth,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 70,
                            child: Container(
                              height: screenHeight - 310,
                              width: screenWidth - 70,
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                borderRadius: BorderRadius.circular(20)
                              ),
                            )
                          ),
                          Positioned(
                              child: BankAccordion()
                          ),
                        ],
                      )
                  )
                ]
            )
        ),
        bottomNavigationBar: mainBottomBar()
    );

  }
}

// ExpansionPanel 정보 저장
class Bank{
  Bank({
    required this.headerValue,
    this.isExpanded = false,
  });

  String headerValue;
  bool isExpanded;
}

// 임시 하드코딩 은행 정보
List<Bank> temp = [Bank(headerValue: '은행')];

class BankAccordion extends StatefulWidget {
  const BankAccordion({super.key});

  @override
  State<BankAccordion> createState() => _BankAccordion();
}

/// MyStatefulWidget의 개인 상태 클래스입니다.
/// SingleChildScrollView로 ExpansionPanelList를 감쌉니다.
class _BankAccordion extends State<BankAccordion> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      child: ExpansionTile(
        title: Text('은행 정보', style: TextStyle(fontSize: 10)),
        minTileHeight: 10,
        tilePadding: EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
          for(int i = 0; i < 5; i++)
            Container(
              width: 120,
              child: FilledButton(onPressed: (){},
                  child: Text('버튼 $i', style: TextStyle(color: Colors.black)),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.grey[100]
                  )
              )
            )
        ],
      )
    );
  }
}

// Container(
//   height: screenHeight - 310,
//   decoration: BoxDecoration(
//     color: Colors.cyanAccent,
//     borderRadius: BorderRadius.circular(20)
//   ),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: <Widget>[
//       Flexible(
//         flex: 3,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.cyanAccent,
//             borderRadius: BorderRadius.circular(20)
//           ),
//         ),
//       ),
//       Flexible(
//         flex: 1,
//         child: Container(
//           decoration: BoxDecoration(
//               color: Colors.cyanAccent,
//               borderRadius: BorderRadius.circular(20)
//           ),
//         )
//       ),
//     ],
//   )
// )