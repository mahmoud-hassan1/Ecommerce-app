import 'package:flutter/material.dart';

import 'Global Variables/Global.dart';
import 'Screens/HomePage.dart';
import 'Screens/account.dart';
import 'Screens/favorites.dart';
import 'constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({super.key});


  @override
  State<NaviBar> createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
 int selectedIndex = 0;
 static  List<Widget> pages=<Widget>[];
 void _refresh() {
     setState(() {});
 }
 @override
 void initState() {
   super.initState();

   pages = <Widget>[
     HomePage(),
     FavoritePage(),
     AccountPage(refresh: _refresh, ),
   ];
 }
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromRGBO(53, 53, 53,1),
        backgroundColor: Global.dark? NavbarColor
         :Color.fromRGBO(227, 227, 227,1),

        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined ,),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorites',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Account',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Global.dark? FontColorDark
            :Purple,
        onTap: _onItemTapped,
      ),
    );
  }
}

