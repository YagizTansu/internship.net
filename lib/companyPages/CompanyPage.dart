import 'package:flutter/material.dart';
import 'package:internship/ProfilePage.dart';
import 'package:internship/companyPages/Published.dart';

import '../internPages/ProcessPage.dart';
import 'PublishInternPage.dart';
import '../internPages/SearchPage.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    PublishInternPage(),
    Published(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body:_pages.elementAt(_selectedIndex),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.publish_outlined),
            label: 'Publish Intern',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Published',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedFontSize: 15,
        selectedItemColor: Colors.deepOrangeAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 3,
      ),
    );
  }
}
