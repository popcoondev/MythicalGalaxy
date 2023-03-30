// import 'package:flutter/material.dart';
//
// class GameBoardPainter extends CustomPainter {
//   final List<List<int>> planetConnections;
//
//   GameBoardPainter(this.planetConnections);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // ...既存の描画コード...
//
//     drawConnections(canvas, size);
//   }
//
//   void drawConnections(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2;
//
//     for (int i = 0; i < 9; i++) {
//       for (int j in planetConnections[i]) {
//         final startX = (i % 3) * size.width / 3 + size.width / 6;
//         final startY = (i ~/ 3) * size.height / 3 + size.height / 6;
//         final endX = (j % 3) * size.width / 3 + size.width / 6;
//         final endY = (j ~/ 3) * size.height / 3 + size.height / 6;
//
//         canvas.drawLine(Offset(startX, startY), Offset(endX, endY
