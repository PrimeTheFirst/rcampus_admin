import 'package:flutter/material.dart';

class AttendenceTable extends StatelessWidget {
  const AttendenceTable({super.key});
  final double? tableNameFontSize = 15;
  final double? helperTextSize = 12;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                width: 32,
                child: const Text(
                  "Attendence",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: SizedBox(
                width: 32,
                child: Text(
                  "Present",
                  style: TextStyle(fontSize: tableNameFontSize),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Absent",
                  style: TextStyle(fontSize: tableNameFontSize),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Boys",
                  style: TextStyle(fontSize: tableNameFontSize),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                margin: const EdgeInsets.only(right: 40),
                child: TextField(
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: helperTextSize),
                      labelText: "Boys present"),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: helperTextSize),
                      labelText: "Boys absent"),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Girls",
                  style: TextStyle(fontSize: tableNameFontSize),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                margin: const EdgeInsets.only(right: 40),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Girls present",
                    labelStyle: TextStyle(fontSize: helperTextSize),
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Girls absent",
                    labelStyle: TextStyle(fontSize: helperTextSize),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
