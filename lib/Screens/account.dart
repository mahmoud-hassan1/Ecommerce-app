import 'package:ecommerce_app/Global%20Variables/Global.dart';
import 'package:ecommerce_app/Screens/LoginPage.dart';
import 'package:ecommerce_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  final Function refresh;

  AccountPage({required this.refresh});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  void performAction() {
    widget.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.dark ? BackgroundColorDark : BackgroundColorLight,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Account",

        ),
        centerTitle: true,
        backgroundColor: Purple,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        AssetImage("assets/images/profile-user.png"),
                    backgroundColor: Colors.white,
                  ),
                  Positioned(
                    bottom: 3,
                    right: 5,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.deepPurple[100]),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        color: Colors.indigo[600],
                        iconSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              Global.username!.length >0?Global.username!:"",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Global.dark ? FontColorDark : Colors.black),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              Global.email!.length>0? Global.email!
              :"",
              style: TextStyle(
                  fontSize: 13,
                  color: Global.dark ? FontColorDark : Colors.black),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Purple),
                    child: Icon(
                      Icons.settings_outlined,
                      color: FontColorDark,
                    ),
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: 20,
                        color: Global.dark ? FontColorDark : Colors.black),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.arrow_forward_ios,
                        color: Global.dark ? FontColorDark : Colors.black),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Purple),
                    child: Icon(
                      Icons.language_outlined,
                      color: FontColorDark,
                    ),
                  ),
                  title: Text(
                    "Language",
                    style: TextStyle(
                        fontSize: 20,
                        color: Global.dark ? FontColorDark : Colors.black),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(Icons.arrow_forward_ios,
                        color: Global.dark ? FontColorDark : Colors.black),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Purple),
                    child: Icon(
                      Icons.color_lens_outlined,
                      color: FontColorDark,
                    ),
                  ),
                  title: Text(
                    "Theme",
                    style: TextStyle(
                        fontSize: 20,
                        color: Global.dark ? FontColorDark : Colors.black),
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Switch(
                        inactiveThumbImage:
                            AssetImage("assets/images/sun.png"),
                        inactiveTrackColor: Colors.orange[200],
                        activeTrackColor: Colors.blueGrey[900],
                        activeThumbImage:
                            AssetImage("assets/images/darkMode.png"),
                        value: Global.dark,
                        onChanged: (value) async{
                          setState(() {
                            Global.dark = !Global.dark;
                            performAction();
                          });
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool("dark", Global.dark);
                        }),
                  )),
            ),
            Container(
              height: 50,
              width: 140,
              child: ElevatedButton(
                onPressed: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('rememberMe', false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                      color: FontColorDark
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Purple,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
