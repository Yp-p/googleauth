import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:googleauth/const/constValue.dart';
import 'package:googleauth/database/busDatabase.dart';

class BusPrice extends StatefulWidget {
  @override
  _BusPriceState createState() => _BusPriceState();
}

class _BusPriceState extends State<BusPrice> {
  String dropDownValue='all';
  List allResult;
  List _resultList;
  Future resultLoad;

  TextEditingController controller=TextEditingController();

  getAllResult() async{
    List<Bus> result= await getBusDatabase();
    setState(() {
      allResult=result;
    });

    searchResultList();
  }

  searchResultList(){
    List showList=[];
    if(controller.text!=''){
      for(var data in allResult) {
        String arrival = data.arrival;
        if(arrival.contains(controller.text)){
          showList.add(data);
        }
      }
    }
    else{
      showList=List.from(allResult);
    }
setState(() {
  _resultList=showList;
});

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    resultLoad=getAllResult();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener(onSearchChange);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(onSearchChange);

  }

  onSearchChange(){
    searchResultList();
  }

  @override
  Widget build(BuildContext context) {
  print(controller.text);
    print(_resultList);

    List itemList(){
      List result=[];
      if(dropDownValue!='all'){
        for (var data in _resultList) {
          String departure = data.departure;
          if (departure.contains(dropDownValue)) {
            result.add(data);
          }
        }
      }else{
        result=_resultList;
      }
      return result;
    }


    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.lightGreen,
                      )
                  ),

                  child: DropdownButton(
                    underline: Container(),
                      onChanged: (value){setState(() {
                  dropDownValue=value;
                  print(dropDownValue);
                      });},
                      // isExpanded: true,
                      value: dropDownValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 30,
                      items: [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text('အားလုံး'),
                        ),
                  DropdownMenuItem(
                    value: 'ရန်ကုန်',
                    child: Text('ရန်ကုန်'),
                  ),
                  DropdownMenuItem(
                    value: 'မန္တလေး',
                    child: Text('မန္တလေး'),
                  )
                      ],
                    ),
                ),
                Icon(Icons.compare_arrows, size: 50,color: gColor,),
                Expanded(
                  child: Container(

                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.lightGreen,
                        )
                    ),
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(

                        border: InputBorder.none,

                        hintText: 'ရှာပါ'
                      ),
                    ),
                  ),
                )
              ],
            ),

           BusItem(result: itemList(),)
          ],
        )
      ),
    );
  }
}

class BusItem extends StatefulWidget {
  final result;

  const BusItem({Key key, this.result}) : super(key: key);
  @override
  _BusItemState createState() => _BusItemState();
}

class _BusItemState extends State<BusItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.result.length,
          itemBuilder: (BuildContext context, int index) {
            Bus bus = widget.result[index];
            return Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: Text(bus.departure)),
                    Expanded(child: Icon(Icons.compare_arrows, size: 30,)),
                    Expanded(child: Text(bus.arrival)),
                    Expanded(child: Text(
                      '${bus.fare} ကျပ်', textAlign: TextAlign.center,),)
                  ],
                ),
              ),
            );
          }
      ),
    );
  }


}
