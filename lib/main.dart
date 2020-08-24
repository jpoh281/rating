import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rating/exercise_review_writting.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  int allCount = 50;
  int first = 10;
  int second = 15;
  int third = 5;
  int forth = 20;
  int fifth = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                print("리뷰보기");
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    "평점 및 리뷰",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  IconButton(
                      iconSize: 15,
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        print("리뷰보기");
                      })
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "4.4", // <- 평점 변수 넣을 곳
                      style: TextStyle(
                          fontSize: Get.width / 4,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    RatingBarIndicator(
                      rating: 4.4,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 15.0,
                      direction: Axis.horizontal,
                    ),
                    Text("200,000")
                  ],
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                ),
                SizedBox(
                    width: Get.width / 2,
                    height: Get.width / 3,
                    child: RotatedBox(
                        quarterTurns: 1, child: BarChart(randomData()))),
              ],
            ),
          ),
          Container(
            height: 30,
          ),
          RatingBar(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              // => 현재 레이팅을 가지고 리뷰 작성페이지로 보내기
              Get.to(ExerciseReviewWriting(exercise: "스쿼트", rating: rating));
            },
          ),
          Column(children: buildComments())
//          ListView.builder(
//              itemCount: 5,
//              itemBuilder: (context, index) =>
//                  buildComment(title: "홍종표", rate: 1.0, body: "운동안해 !")),
        ],
      ),
    )));
  }

  List<Widget> buildComments() {
    List<Widget> commentTiles = [];
    for (int i = 0; i < 10; i++) {
      commentTiles.add(buildComment(title: "홍종표", rate: 1.0, body: "운동안해 !"));
    }
    return commentTiles;
  }

  Padding buildComment({String title, double rate, String body}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("$title"),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              RatingBarIndicator(
                rating: rate,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 15.0,
                direction: Axis.horizontal,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                DateFormat("yyyy-MM-dd HH:mm")
                    .parse(DateTime.now().toString())
                    .toString(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("$body")
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 10,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            color: Colors.grey,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          rotateAngle: 270,
          showTitles: true,
          textStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '1';
              case 1:
                return '2';
              case 2:
                return '3';
              case 3:
                return '4';
              case 4:
                return '5';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(5, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, (first / allCount) * 100,
                barColor: Colors.green);
          case 1:
            return makeGroupData(1, (second / allCount) * 100,
                barColor: Colors.green);
          case 2:
            return makeGroupData(2, (third / allCount) * 100,
                barColor: Colors.green);
          case 3:
            return makeGroupData(3, (forth / allCount) * 100,
                barColor: Colors.green);
          case 4:
            return makeGroupData(4, (fifth / allCount) * 100,
                barColor: Colors.green);
          default:
            return null;
        }
      }),
      minY: 0,
      maxY: 100,
    );
  }
}
