import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'attendence_table.dart';
import 'globals.dart' as globals;
import 'subjectInputWidgets.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
                      onPressed: () {
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

  void createAndUploadXL() async {
    final prefs = await SharedPreferences.getInstance();
    var db = await md.Db.create(
        "mongodb+srv://prat:anshu9002@rcampus.bxpfcyb.mongodb.net/?retryWrites=true&w=majority&appName=rcampus");
    await db.open();
    List subjectData = [];
    for (int i = 0; i < globals.inputControllers["Topic"]!.length; i++) {
      subjectData.add({
        'subject': globals.inputControllers["Subject"]![i],
        'topic': globals.inputControllers["Topic"]![i].text,
        'subTopic': globals.inputControllers["Sub Topic"]![i].text,
        'cw': globals.inputControllers["Class work"]![i].text,
        'hw': globals.inputControllers["Home work"]![i].text,
        "sd": globals.inputControllers["Submission date"]![i].text
      });
    }
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var collection = db.collection(prefs.getString('class') ?? '0A');
    await collection.insert({"date": formattedDate, "subjects": subjectData});
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
  TextEditingController grade = TextEditingController();
  TextEditingController section = TextEditingController();
  String hwclass = '0A';
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
      hwclass = prefs.getString('class') ?? '0A';
      section = TextEditingController(text: hwclass[hwclass.length - 1]);
      grade =
          TextEditingController(text: hwclass.substring(0, hwclass.length - 1));
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
            CustomCard(
                child: MultiSelectDialogField(
              backgroundColor: Colors.white,
              checkColor: Colors.white,
              items: finalOptions,
              onConfirm: (values) {
                selectedSubjects = values;
              },
              initialValue: _preSelectedSubjectList,
            ))
          ],
        ),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  controller: grade,
                  decoration: const InputDecoration(labelText: "Enter grade"),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  controller: section,
                  decoration: const InputDecoration(labelText: "Enter section"),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.clear();
            List<String> selectedSubjectsStringList = List<String>.from(
                selectedSubjects.map((e) => '${e.name}__${e.id}'));
            prefs.setStringList('subjects', selectedSubjectsStringList);
            prefs.setString('class', grade.text + section.text.toUpperCase());
          },
          child: const Text('Set subjects'),
        ),
      ]),
    );
  }
}
