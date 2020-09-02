import 'package:flutter/material.dart';
import 'package:googleauth/const/constValue.dart';

class CategoryModel{
  final String title;
  final String descrip;
  final String image;

  CategoryModel({this.title, this.descrip, this.image});
}

class CategoryItem extends StatelessWidget {
  final List<CategoryModel> _catList=[
    CategoryModel(
        title: 'သွားမယ် လည်မယ်',
        descrip: 'ခရီးသွားခြင်းဖြင့် သင့်ရဲ့ ပျော်ရွှင်မှုတွေကို ဖန်တီးလိုက်ပါ',
        image: 'images/bagan.jpg'
    ),
    CategoryModel(
        title: 'သွားမယ် လည်မယ်',
        descrip: 'ခရီးသွားခြင်းဖြင့် သင့်ရဲ့ ပျော်ရွှင်မှုတွေကို ဖန်တီးလိုက်ပါ',
        image: 'images/bagan.jpg'
    ),
    CategoryModel(
        title: 'သွားမယ် လည်မယ်',
        descrip: 'ခရီးသွားခြင်းဖြင့် သင့်ရဲ့ ပျော်ရွှင်မှုတွေကို ဖန်တီးလိုက်ပါ',
        image: 'images/bagan.jpg'
    )
  ];

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return ListView.builder(
        itemCount: _catList.length,
        itemBuilder: (BuildContext context, int index){
          CategoryModel categoryModel=_catList[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.9,
                height: 130,
                child: Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            categoryModel.image,
                            fit: BoxFit.fill,
                            width: 120,
                            height: 110,
                          )),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              categoryModel.title,
                              style: TextStyle(color: gColor, fontSize: 20),
                            ),
                            Text(
                              categoryModel.descrip,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }) ;

  }
}
