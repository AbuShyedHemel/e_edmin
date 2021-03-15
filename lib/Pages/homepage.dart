import 'package:e_edmin/Pages/dashboard.dart';
import 'package:e_edmin/Pages/management.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentindex = 0;
  final List<Widget> tabs = [Dashboard(),Management()];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange[800],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        iconSize: 17,
        selectedFontSize: 13,
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
              title: Text("DashBoard"), icon: Icon(Icons.dashboard)),
          BottomNavigationBarItem(
              title: Text("Management"), icon: Icon(Icons.settings)),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}
