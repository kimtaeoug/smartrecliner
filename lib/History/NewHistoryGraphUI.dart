// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: LineChart(
//               structure(),
//               swapAnimationDuration: Duration(milliseconds: 250),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   //UI, XAxis, YAxis
//   LineChartData structure() {
//     return LineChartData(
//         lineTouchData: LineTouchData(enabled: true),
//         gridData:FlGridData(
//           show: true,
//           drawVerticalLine: false,
//           drawHorizontalLine: true,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d).withOpacity(0.7),
//               strokeWidth: 0.5,
//             );
//           },
//         ),
//         titlesData: FlTitlesData(
//           //x축
//             bottomTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 22,
//               getTextStyles: (value) => const TextStyle(
//                   color: Color(0xff72719b),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//               margin: 10,
//               //x축 범례
//               getTitles: (value) {
//                 switch (value.toInt()) {
//                   case 2:
//                     return 'SEPT';
//                   case 7:
//                     return 'OCT';
//                   case 12:
//                     return 'DEC';
//                 }
//                 return '';
//               },
//             ),
//             //y축
//             leftTitles: SideTitles(
//                 showTitles: true,
//                 getTextStyles: (value) => const TextStyle(
//                     color: Color(0xff75729e),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14),
//                 //y축 범례
//                 getTitles: (value) {
//                   switch (value.toInt()) {
//                     case 1:
//                       return '1m';
//                     case 2:
//                       return '2m';
//                     case 3:
//                       return '3m';
//                     case 4:
//                       return '5m';
//                     case 5:
//                       return '6m';
//                   }
//                   return '';
//                 },
//                 margin: 8,
//                 reservedSize: 30)),
//         borderData: FlBorderData(
//             show: true,
//             border: const Border(
//                 bottom: BorderSide(color: Color(0xff4e4965), width: 4),
//                 left: BorderSide(color: Colors.transparent),
//                 right: BorderSide(color: Colors.transparent),
//                 top: BorderSide(color: Colors.transparent))),
//         minX: 0,
//         maxX: 14,
//         minY: 0,
//         maxY: 6,
//         //데이터
//         lineBarsData: linesBarData());
//   }
//
//   List<LineChartBarData> linesBarData() {
//     return [
//       LineChartBarData(
//         spots: [
//           FlSpot(1, 3.8),
//           FlSpot(3, 1.9),
//           FlSpot(6, 5),
//           FlSpot(10, 3.3),
//           FlSpot(13, 4.5),
//         ],
//         isCurved: true,
//         curveSmoothness: 0,
//         colors:  [
//           Color(0xffd8b1e5).withOpacity(0.6),
//         ],
//         barWidth: 2,
//         isStrokeCapRound: true,
//         dotData: FlDotData(show: true),
//         belowBarData: BarAreaData(
//           show: false,
//         ),
//       ),
//       LineChartBarData(
//         spots: [
//           FlSpot(2, 1.8),
//           FlSpot(3, 4.9),
//           FlSpot(6, 3),
//           FlSpot(10, 1),
//           FlSpot(13, 5),
//         ],
//         isCurved: true,
//         curveSmoothness: 0,
//         colors:  [
//           Color(0xff6CB9CD).withOpacity(0.6),
//         ],
//         barWidth: 2,
//         isStrokeCapRound: true,
//         dotData: FlDotData(show: true),
//         belowBarData: BarAreaData(
//           show: false,
//         ),
//       ),
//     ];
//   }
// }
//
