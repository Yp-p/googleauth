import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/page/CategoryPage.dart';
import 'package:googleauth/page/firstPage.dart';
import 'package:googleauth/page/savePage.dart';
import 'package:googleauth/page/userInfoPage.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  final VoidCallback logOutCallback;

  const HomePage({Key key, this.logOutCallback}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

Future<void> _lunch;
String _phone;



  int _selectIndex = 0;
  List widgetList(){
    List<Widget> _widgetOption = <Widget>[
      FirstPage(),
      SavePage(),
      CategoryItem(),
      UserInfo(logOutCallBack: widget.logOutCallback,),
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
                  ClipRRect(
                    child: Image.asset('images/division/sagaing.jpg',width: 100, height: 100,fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(100),

                  ),
                  Text('Yan Paing Phyo', style: TextStyle(fontSize: 18),),
                  Text('yanpaingphyoeypp@gmail.com', style: TextStyle(fontSize: 12),)
                ],
              )
            ),
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
            ),
            Divider(),
            ListTile(
              onTap: (){
                Share.share('jj',
                    subject: 'jj',
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
