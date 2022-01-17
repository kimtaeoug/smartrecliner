import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:smartrecliner_flutter/UISupport/ReclinerColor.dart';

class BloodPressureGraphUI extends CustomPainter{
  ReclinerColor _reclinerColor = ReclinerColor();
  double textScaleFactorXAxis = 1.0; // x축 텍스트의 비율을 정함.
  double textScaleFactorYAxis = 1.2; // y축 텍스트의 비율을 정함.

  List<double> sdata = [];
  List<double> ddata = [];
  List<String> labels = [];
  double bottomPadding = 0.0;
  double leftPadding = 0.0;
  String healthItem = '';

  BloodPressureGraphUI(
      {required this.healthItem, required this.sdata,required this.ddata, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    setTextPadding(size); // 텍스트를 공간을 미리 정함.

    List<Offset> coordinates = getCoordinates(size);

    drawYLabels(canvas, size);
    drawLines(canvas, size, coordinates);
    drawBar(canvas, size, coordinates);
  }

  //글자의 패딩
  void setTextPadding(Size size) {
    bottomPadding = size.height / 10; // 세로 크기의 1/10만큼만 텍스트 패딩을 줌
    leftPadding = size.width / 10; // 가로 길이의 1/10만큼 텍스트 패딩을 줌
  }

  //막대 그리는 부분
  void drawBar(Canvas canvas, Size size, List<Offset> coordinates) {
    Paint paint = Paint()
      ..color = _reclinerColor.purple
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    Paint dpaint = Paint()
      ..color = _reclinerColor.yellow
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    double xAxisUnit = 0.0;
    if(sdata.length > 7){
      xAxisUnit = size.width / (sdata.length + 1);
    }else{
      xAxisUnit = size.width / 7;
    }
    double yAxisUnit = size.height / 5;
    for (int idx = 0; idx < sdata.length; idx++) {
      double xMove = xAxisUnit * (idx) + xAxisUnit;
      double yMove = size.height - ((size.height - 2*bottomPadding)*sdata[idx])/220 - bottomPadding;
      double dMove = size.height - ((size.height - 2*bottomPadding)*ddata[idx])/220 - bottomPadding;
      canvas.drawCircle(Offset(xMove + 11, yMove), 8, paint);
      canvas.drawCircle(Offset(xMove + 11, dMove), 8, dpaint);
      //x축 legend
      TextSpan span = TextSpan(
          style: TextStyle(
              color: _reclinerColor.dark2,
              fontSize: 9,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400),
          text: labels[idx]);

      TextPainter tp =
      TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(xMove, size.height - yAxisUnit / 4));
    }
  }


  // Y축 텍스트(레이블)을 그림. 최저값과 최고값을 Y축에 표시함.
  void drawYLabels(Canvas canvas, Size size) {
    List<int> healthRange = [];
    switch (healthItem) {
      case '심박수':
        healthRange = [0, 40, 80, 120, 160];
        break;
      case '혈압':
        healthRange = [0, 55, 110, 165, 220];
        break;
      case '스트레스':
        healthRange = [0, 25, 50, 75, 100];
        break;
      case '몸무게':
        healthRange = [0, 50, 100, 150, 200];
        break;
    }
    double yAxis = size.height / 5;
    double refineHeight = size.height / 45;
    for (int idx = 1; idx <= healthRange.length; idx++) {
      drawYText(canvas, healthRange[healthRange.length - idx].toString(), 11,
          yAxis * (idx - 1) + leftPadding - refineHeight);
    }
  }

  // 화면 크기에 비례해 폰트 크기를 계산.
  double calculateFontSize(String value, Size size, {required bool xAxis}) {
    int numberOfCharacters = value.length; // 글자수에 따라 폰트 크기를 계산하기 위함.
    double fontSize = (size.width / numberOfCharacters) /
        sdata.length; // width가 600일 때 100글자를 적어야 한다면, fontSize는 글자 하나당 6이어야겠죠.

    if (xAxis) {
      fontSize *= textScaleFactorXAxis;
    } else {
      fontSize *= textScaleFactorYAxis;
    }

    return fontSize;
  }

  // x축과 y축을 구분하는 선을 긋습니다.
  void drawLines(Canvas canvas, Size size, List<Offset> coordinates) {
    Paint paint = Paint()
      ..color = _reclinerColor.grey2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    //x축과 글자가 겹치지 않게
    double left = coordinates[0].dx;

    double xAxisUnit = size.height / 5;
    //moveTo
    //하위 경로의 시작 지점을 메서드 내에 제공된 지점으로 이동
    //lineTo - 현재 지점에서 메서드 내에 제공된 지점까지 선을 그림
    Path path = Path();
    path.moveTo(left, 0);
    for (int idx = 1; idx < 6; idx++) {
      path.moveTo(left, xAxisUnit * (idx - 1) + leftPadding);
      path.lineTo(size.width, xAxisUnit * (idx - 1) + leftPadding);
    }
    canvas.drawPath(path, paint);
  }

  //y축 범례 하나
  void drawYText(Canvas canvas, String text, double fontSize, double y) {
    TextSpan span = TextSpan(
      style: TextStyle(
          fontSize: fontSize,
          color: _reclinerColor.dark2,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600),
      text: text,
    );

    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);

    tp.layout();

    Offset offset = Offset(0.0, y);
    tp.paint(canvas, offset);
  }

  List<Offset> getCoordinates(Size size) {
    List<Offset> coordinates = [];

    double maxData = sdata.reduce(max);

    double width = size.width - leftPadding;
    double minBarWidth = width / sdata.length;

    for (var index = 0; index < sdata.length; index++) {
      double left = minBarWidth * (index) + leftPadding; // 그래프의 가로 위치를 정합니다.
      double normalized =
          sdata[index] / maxData; // 그래프의 높이가 [0~1] 사이가 되도록 정규화 합니다.
      double height =
          size.height - bottomPadding; // x축에 표시되는 글자들과 겹치지 않게 높이에서 패딩을 제외합니다.
      double top = height - normalized * height; // 정규화된 값을 통해 높이를 구해줍니다.

      Offset offset = Offset(left, top);
      coordinates.add(offset);
    }

    return coordinates;
  }

  @override
  bool shouldRepaint(BloodPressureGraphUI old) {
    return old.sdata != sdata;
  }
}
