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

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<String>? subjects = [];
  List<MultiSelectItem<String>> preSelectedSubjectList = [];
  List selectedSubjects = [];
  Map optionList = {
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
    'EN': 'English literature',
    'HC': 'History and civics',
    'PE': 'Physical education',
    'mmc': 'MMC'
  };
  List<MultiSelectItem<String>> options = [
    // MultiSelectItem('P', 'Physics'),
    // MultiSelectItem('C', 'Chemistry'),
    // MultiSelectItem('M', 'Maths'),
    // MultiSelectItem('B', 'Biology'),
    // MultiSelectItem('Cs', 'Computer'),
    // MultiSelectItem('A', 'Art'),
    // MultiSelectItem('S', 'Science'),
    // MultiSelectItem('G', 'Geography'),
    // MultiSelectItem('H', 'Hindi'),
    // MultiSelectItem('K', 'Kannada'),
    // MultiSelectItem('EL', 'English literature'),
    // MultiSelectItem('EN', 'nglish literature'),
    // MultiSelectItem('HC', 'History and civics'),
    // MultiSelectItem('PE', 'Physical education'),
    // MultiSelectItem('MMC', 'MMC')
  ];

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
      print(subjects);
      //TODO: set the subject list if its empty
      if (subjects!.isNotEmpty) {
        preSelectedSubjectList = subjects!
            .map((e) =>
                MultiSelectItem<String>(e.split('__')[1], e.split('__')[0]))
            .toList();
      }
      optionList.forEach((k, v) => options.add(MultiSelectItem('$k', '$v')));
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
                  items: options,
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
                selectedSubjects.map((e) => '${optionList[e]}__$e'));
            prefs.setStringList('subjects', selectedSubjectsStringList);
          },
          child: const Text('Set subjects'),
        ),
      ]),
    );
  }
}
