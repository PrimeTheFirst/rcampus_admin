import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('First Route'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
            ),
          ],
        ),
        body: const Text("Cool"));
  }
}

class Subject {
  final String id;
  final String name;

  Subject({
    required this.id,
    required this.name,
  });
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<String>? subjects = [];
  static List<Subject> preSelectedSubjectList = [];
  List selectedSubjects = [];
  static List<Subject> optionList = [
    // Subject(id: 'P', name: 'Physics'),
    // Subject(id: 'C', name: 'Chemistry'),
    // Subject(id: 'M', name: 'Maths'),
    // Subject(id: 'B', name: 'Biology'),
    // Subject(id: 'Cs', name: 'Computer'),
    // Subject(id: 'A', name: 'Art'),
    // Subject(id: 'S', name: 'Science'),
    // Subject(id: 'G', name: 'Geography'),
    // Subject(id: 'H', name: 'Hindi'),
    // Subject(id: 'K', name: 'Kannada'),
    // Subject(id: 'EL', name: 'English literature'),
    // Subject(id: 'EN', name: 'English literature'),
    // Subject(id: 'HC', name: 'History and civics'),
    // Subject(id: 'PE', name: 'Physical education'),
    // Subject(id: 'mmc', name: 'MMC')
  ];
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
    'EN': 'nglish literature',
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
      print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
      print("Subjects $subjects");
      //TODO: set the subject list if its empty
      if (subjects!.isNotEmpty) {
        preSelectedSubjectList = subjects!
            .map((e) => Subject(id: e.split('__')[1], name: e.split('__')[0]))
            .toList();
        print(preSelectedSubjectList);
      }
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
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Subject selection: ",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
                child: MultiSelectDialogField(
                  items: finalOptions,
                  // icon: const Icon(Icons.check),
                  onConfirm: (values) {
                    selectedSubjects = values;
                  },
                  initialValue: preSelectedSubjectList,
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            print(selectedSubjects);
            List<String> selectedSubjectsStringList = List<String>.from(
                selectedSubjects.map((e) => '${e.name}__${e.id}'));
            print(selectedSubjectsStringList);
            prefs.setStringList('subjects', selectedSubjectsStringList);
          },
          child: const Text('Set subjects'),
        ),
      ]),
    );
  }
}
