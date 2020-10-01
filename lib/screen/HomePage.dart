import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/dark_mode/dark_setting.dart';
import 'package:googleauth/page/CategoryPage.dart';
import 'package:googleauth/page/firstPage.dart';
import 'package:googleauth/page/savePage.dart';
import 'package:googleauth/page/userInfoPage.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: "com.ypp.googleauth",
  );

  rateMyApp(){
    _rateMyApp.init().then((_){
      // if(_rateMyApp.shouldOpenDialog){
        _rateMyApp.showStarRateDialog(
          context,
          title: 'အဆင့်သတ်မှတ်ပေးပါ', // The dialog title.
          message: 'App သုံးရတာ အဆင်ပြေရဲ့လား။', // The dialog message.
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          actionsBuilder: (context, stars) { // Triggered when the user updates the star rating.
            return [ // Return a list of actions (that will be shown at the bottom of the dialog).
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
                  // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                  // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                  await _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
                },
              ),
            ];
          },
          ignoreNativeDialog: Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          dialogStyle: DialogStyle( // Custom dialog styles.
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20),
          ),
          starRatingOptions: StarRatingOptions(
            starsBorderColor: gColor,
            starsFillColor: gColor
          ), // Custom star bar rating options.
          onDismissed: () => _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
        );
      // }
    });

  }



Future<void> _lunch;
String _phone;
bool isDark=false;



  int _selectIndex = 0;
  List widgetList(){
    List<Widget> _widgetOption = <Widget>[
      FirstPage(),
      SavePage(),
      CategoryItem(),
      UserInfo(),
    ];
    return _widgetOption;
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Future<void> _makeLunchApp(String url) async{

    if(await canLaunch(url)){
      launch(url);
    }else{
      throw ('Could not Lauch $url');
    }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // rateMyApp();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: ColorizeAnimatedTextKit(
            totalRepeatCount: 200,
              onTap: () {
                print("Tap Event");
              },
              text: [
                "မင်္ဂလာပါ...",
                "ပျော်ရွှင်ဖွယ်ခရီစဉ်လေး",
                "ဖြစ်ပါစေ...",
              ],
              textStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Horizon"
              ),
              colors: [
                Colors.purple,
                Colors.blue,
                Colors.yellow,
                Colors.red,
              ],
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
          ),
        ),

        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: gColor),
        elevation: 0,
        // iconTheme: IconThemeData(color: gColor),
      ),
      body: widgetList().elementAt(_selectIndex),
      drawer: Drawer(
        elevation: 10,
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Text('Developer By', style: TextStyle(fontSize: 10),),
                  ClipRRect(
                    child: Image.asset('images/bagan.jpg',width: 100, height: 100,fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(100),

                  ),

                  Text('Developer by', style: TextStyle(fontSize: 12),),
                  Text('Yan Paing Phyo', style: TextStyle(fontSize: 18),),
                ],
              )
            ),


            ListTile(
              onTap: (){

              },
              leading: Icon(Icons.brightness_4),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: isDark,
                onChanged: (value){
                  setState(() {
                    isDark=value;
                  });
                  Provider.of<DarkSetting>(context, listen: false).switchTheme();
                },
              ),
            ),
            Divider(),
            ListTile(
              onTap: (){


                _lunch=_makeLunchApp('mailto:yanpaingphyoeypp@gmail.com?subject=Greetings&body=Please Feedback me');

              } ,
              leading: Icon(Icons.feedback),
              title: Text('အကြံပြုစာပို့ရန်'),

            ),
            Divider(),
            ListTile(

              leading: Icon(Icons.stars),
              title: Text('အဆင့်သတ်မှတ်ပေးမည်'),

              onTap: rateMyApp,
            ),
            Divider(),
            ListTile(
              onTap: (){
                Share.share('https://play.google.com/store/apps/details?id=com.ypp.googleauth',
                    subject: 'https://play.google.com/store/apps/details?id=com.ypp.googleauth',
                    );

              },
              leading: Icon(Icons.share),
              title: Text('App အားမျှဝေမည်'),
            ),
            Divider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        elevation: 10,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('ပင်မ')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('သိမ်းထား')),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('ကဏ္ဍ')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account), title: Text('အကောင့်')),
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
