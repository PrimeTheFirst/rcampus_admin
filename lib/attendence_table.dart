import 'package:flutter/material.dart';

class AttendenceTable extends StatelessWidget {
  const AttendenceTable({super.key});
  final double? tableNameFontSize = 15;
  final double? helperTextSize = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
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
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: helperTextSize),
                          labelText: "Total boys "),
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
                          labelText: "Total snacks"),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
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
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Total girls",
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
                        labelText: "Total lunch",
                        labelStyle: TextStyle(fontSize: helperTextSize),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(labelText: "Absentees:"),
          ),
        ),
      ],
    );
  }
}
