import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'attendence_table.dart';
import 'globals.dart' as globals;
import 'subjectInputWidgets.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  List<String>? subjects = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Method to load the shared preference data
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      subjects = prefs.getStringList('subjects');
      if (subjects!.isEmpty) {
        subjects = ["Math__m"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          "Rcampus admin",
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              // color: Colors.white,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
              if (mounted) {
                setState(() {
                  _loadPreferences();
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 178, 250, 184),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 170, 255, 234)
                        .withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [AttendenceTable()],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: subjects!
                        .map((e) => SubjectInputs(
                              subject: e,
                            ))
                        .toList(),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        createAndUploadXL();
                      },
                      child: const Text("Upload"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createAndUploadXL() {
    Excel excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    int category = 0, subject = 0;
    bool blank = false;
    print(globals.inputControllers[globals.inputCategorys[category]]);
    for (int i = 1; i <= subjects!.length * 7; i++) {
      if (!blank) {
        var cell = sheetObject.cell(CellIndex.indexByString('A$i'));
        cell.value = TextCellValue(globals.inputCategorys[category]);

        cell = sheetObject.cell(CellIndex.indexByString('B$i'));
        cell.value = TextCellValue(globals
            .inputControllers[globals.inputCategorys[category]]![subject].text);
      }
      if (category == 4) {
        category = -1;
        blank = true;
      }
      if (i % 7 == 0) {
        subject++;
        blank = false;
        category = -1;
      }
      category++;
    }

    var fileBytes = excel.save();

    File(join('E:/output_file_name.xlsx'))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
  }
}

class Subject {
  final String id;
  final String name;

  const Subject({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Subject && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<String>? subjects = [];
  List<Subject> _preSelectedSubjectList = [];
  List selectedSubjects = [];
  static List<Subject> optionList = [];
  List<MultiSelectItem<Subject>> finalOptions = [];
  Map subjectsList = {
    'P': 'Physics',
    'C': 'Chemistry',
    'M': 'Maths',
    'B': 'Biology',
    'Cs': 'Computer',
    'A': 'Art',
    'S': 'Science',
    'G': 'Geography',
    'H': 'Hindi',
    'K': 'Kannada',
    'EL': 'English literature',
    'EN': 'English Language',
    'HC': 'History and civics',
    'PE': 'Physical education',
    'MMC': 'MMC',
  };
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Method to load the shared preference data
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    setState(() {
      subjects = prefs.getStringList('subjects') ?? [];
      if (subjects!.isNotEmpty) {
        _preSelectedSubjectList = subjects!
            .map((e) => Subject(id: e.split('__')[1], name: e.split('__')[0]))
            .toList();
      }
      optionList = [];
      finalOptions = [];
      subjectsList.forEach((key, value) {
        optionList.add(Subject(id: key, name: value));
      }); //Populating subjectsList
      finalOptions = optionList
          .map((e) => MultiSelectItem<Subject>(e, e.name))
          .toList(); //Pupulating final options
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Subject selection: ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 254, 254)
                        .withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MultiSelectDialogField(
                  backgroundColor: Colors.white,
                  checkColor: Colors.white,
                  items: finalOptions,
                  onConfirm: (values) {
                    selectedSubjects = values;
                  },
                  initialValue: _preSelectedSubjectList,
                ),
              ),
            )
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.clear();
            List<String> selectedSubjectsStringList = List<String>.from(
                selectedSubjects.map((e) => '${e.name}__${e.id}'));
            prefs.setStringList('subjects', selectedSubjectsStringList);
          },
          child: const Text('Set subjects'),
        ),
      ]),
    );
  }
}
