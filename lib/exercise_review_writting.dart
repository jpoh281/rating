import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ExerciseReviewWriting extends StatelessWidget {
  final rating;
  final exercise;
  const ExerciseReviewWriting({Key key, this.exercise, this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("$exercise 평가 및 리뷰"),
        actions: <Widget>[FlatButton(onPressed: () {}, child: Text("게시"))],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Get.height / 10,
            ),
            RatingBar(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              onRatingUpdate: (rating) {},
            ),
            TextField(
              maxLength: 500,
              decoration: InputDecoration(
                  helperText: "운동경험에 대해 작성(선택사항)",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            )
          ],
        ),
      ),
    ));
  }
}
