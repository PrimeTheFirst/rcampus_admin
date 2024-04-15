import 'package:flutter/material.dart';
import 'package:rcampus_admin/globals.dart' as globals;

class SingleSubjectInput extends StatelessWidget {
  final String helperText;
  final TextEditingController controller;
  const SingleSubjectInput(
      {super.key, required this.helperText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: helperText,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

class SubjectInputs extends StatefulWidget {
  final String subject;

  const SubjectInputs({super.key, required this.subject});

  @override
  State<SubjectInputs> createState() => _SubjectInputsState();
}

class _SubjectInputsState extends State<SubjectInputs> {
  final List CategoryInput = [];

  @override
  void initState() {
    super.initState();
    for (var e in globals.inputCategorys) {
      final TextEditingController controller = TextEditingController();
      print(e);
      globals.inputControllers[e]!.add(controller);
      CategoryInput.add(SingleSubjectInput(
        helperText: e,
        controller: controller,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 254, 254).withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 8,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Text(widget.subject.split("__")[0],
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                )),
            ...CategoryInput
          ],
        ),
      ),
    );
  }
}
