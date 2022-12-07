import 'package:flutter/material.dart';
import 'package:internship/HomePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 0;
                });
              },
              icon: Icon(
                Icons.home,
                color:
                    currentPage == 0 ? Colors.deepOrangeAccent : Colors.black,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 1;
                });
              },
              icon: Icon(
                Icons.search,
                color:
                    currentPage == 1 ? Colors.deepOrangeAccent : Colors.black,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 2;
                });
              },
              icon: Icon(
                Icons.notifications,
                color:
                    currentPage == 2 ? Colors.deepOrangeAccent : Colors.black,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  currentPage = 3;
                });
              },
              icon: Icon(
                Icons.person,
                color:
                    currentPage == 3 ? Colors.deepOrangeAccent : Colors.black,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
