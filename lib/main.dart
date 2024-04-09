import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
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
  final MultiSelectController _controller = MultiSelectController();
  List<String>? subjects = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Method to load the shared preference data
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    setState(() {
      subjects = prefs.getStringList('subjects') ?? [];
      //TODO: set the subject list if its empty
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
                child: MultiSelectDropDown(
                  controller: _controller,
                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                  options: const <ValueItem>[
                    ValueItem(label: 'Physics', value: 'P'),
                    ValueItem(label: 'Chemistry', value: 'C'),
                    ValueItem(label: 'Maths', value: 'M'),
                    ValueItem(label: 'Biology', value: 'B'),
                    ValueItem(label: 'Computer', value: 'Cs'),
                    ValueItem(label: 'Art', value: 'A'),
                    ValueItem(label: 'Science', value: 'S'),
                    ValueItem(label: 'Geography', value: 'G'),
                    ValueItem(label: 'Hindi', value: 'H'),
                    ValueItem(label: 'Kannada', value: 'K'),
                    ValueItem(label: 'English literature', value: 'EL'),
                    ValueItem(label: 'English language', value: 'EN'),
                    ValueItem(label: 'History and civics', value: 'HC'),
                    ValueItem(label: 'Physical education', value: 'PE'),
                    ValueItem(label: 'MMC', value: 'MMC'),
                  ],
                  selectionType: SelectionType.multi,
                  chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                  dropdownHeight: 300,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                  searchEnabled: true,
                  searchLabel: "Search Subject",
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setStringList(
                'subjects',
                _controller.selectedOptions
                    .map((e) => "${e.label}__${e.value}")
                    .toList());
          },
          child: const Text('Get Selected Options'),
        ),
      ]),
    );
  }
}
