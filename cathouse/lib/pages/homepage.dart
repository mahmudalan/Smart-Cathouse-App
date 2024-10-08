import 'package:cathouse/pages/chartpage.dart';
import 'package:cathouse/pages/dashboardpage.dart';
import 'package:cathouse/pages/navbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'cathousepage.dart';
import 'dispenserpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final items = [
    Image.asset('lib/assets/activity.png', color: const Color(0xff747264),height: 25,),
    Image.asset('lib/assets/graph.png', color: const Color(0xff747264),height: 25),
    Image.asset('lib/assets/food.png', color: const Color(0xff747264),height: 25),
    Image.asset('lib/assets/pet-house.png', color: const Color(0xff747264),height: 25),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEDEB),
      drawer: const NavBar(),
      appBar: AppBar(
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded))],
        title: const Center(
          child: Text('SMART CATHOUSE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Paratha',
            color: Color(0xff3C3633)
          ),
          ),
        ),
        backgroundColor: const Color(0xffE0CCBE),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: const Color(0xffE0CCBE),
          animationDuration: const Duration(milliseconds: 300),
          height: 60,
          buttonBackgroundColor: const Color(0xff3C3633),
          items: items,
          index: index,
            onTap: (selectedIndex){
              setState(() {
                index = selectedIndex;
              });
            }
      ),
      
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child : getSelectedWidget(index: index)
      ),
    );
  }

  Widget getSelectedWidget({required int index}){
    Widget widget;
    switch(index){
      case 0:
        widget = const DashboardPage();
        break;
      case 1:
        widget = const Chartpage();
        break;
      case 2:
        widget = const Dispenser();
        break;
      case 3:
        widget = const Cathouse();
        break;
      default:
        widget = const DashboardPage();
        break;
    }
    return widget;
  }
}

