import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/authentication/cloudfirestore/ColudFireStroeUpdate.dart';
import 'package:googleauth/authentication/firebasestore.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/page/CategoryPage.dart';
import 'package:googleauth/page/addFireStore.dart';
import 'package:googleauth/page/divisionPage.dart';
import 'package:googleauth/page/firstPage.dart';
import 'package:googleauth/page/savePage.dart';
import 'package:googleauth/page/userInfoPage.dart';

// import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

Future<void> _lunch;
String _phone;



  int _selectIndex = 0;
  static List<Widget> _widgetOption = <Widget>[
    AddFirestore(),
    SavePage(),
    CategoryItem(),
    UserInfo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

//   Future<void> _makePhoneCall(String url) async{
//
//     if(await canLaunch(url)){
//       launch(url);
//     }else{
//       throw ('Could not Lauch $url');
//     }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('ဘာညာကွိကွ'),
        backgroundColor: gColor,
        elevation: 0,
        // iconTheme: IconThemeData(color: gColor),
      ),
      body: _widgetOption.elementAt(_selectIndex),
      drawer: Drawer(
        elevation: 10,
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: gColor,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              onTap: (){


                // _lunch=_makePhoneCall('tel:+959 454440086');
                print('hhhh');
              } ,
              leading: Icon(Icons.message),
              title: Text('Messages'),

            ),
            ListTile(

              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Save')),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('Category')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account), title: Text('Account')),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: gColor,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
