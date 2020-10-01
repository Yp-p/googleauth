import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlaceHistory extends StatefulWidget {
  final Map data;

  const PlaceHistory({Key key, this.data}) : super(key: key);

  @override
  _PlaceHistoryState createState() => _PlaceHistoryState();
}

class _PlaceHistoryState extends State<PlaceHistory> {
  String photoUrl;

  Future downLoadImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('placeImage/${widget.data['placeName']}');
    String imageUrl = await storageReference.getDownloadURL();

    setState(() {
      photoUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    downLoadImage();
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.data['placeName']}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('အချက်အလက်'),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Text('${widget.data['description']}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
