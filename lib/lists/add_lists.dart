import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class AddListPage extends StatefulWidget {
  const AddListPage({Key? key}) : super(key: key);

  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  final _formKey = GlobalKey<FormState>();

  final subjectGoal = TextEditingController();
  final chapterNameController = TextEditingController();
  String selectedConfType = 'Math';
  DateTime? selectedConfDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    subjectGoal.dispose();
    chapterNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter a new List to the Timetable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'subject Goal',
                  hintText: 'enter the purpose of subject',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'you have to complete the text';
                  }
                  return null;
                },
                controller: subjectGoal,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'chapter',
                  hintText: 'entre the name of the chapter',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'you have to complete the text';
                  }
                  return null;
                },
                controller: chapterNameController,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                items: const [
                  DropdownMenuItem(value: 'Math', child: Text('Mathematic')),
                  DropdownMenuItem(value: 'Info', child: Text('Informatic')),
                  DropdownMenuItem(value: 'English', child: Text('English'))
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedConfType,
                onChanged: (value) {
                  setState(() {
                    selectedConfType = value.toString();
                  });
                },
              ),
              const SizedBox(height: 10),
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Date',
                ),
                firstDate: DateTime.now().add(const Duration(days: 10)),
                lastDate: DateTime.now().add(const Duration(days: 40)),
                initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                onChanged: (DateTime? value) {
                  setState(() {
                    selectedConfDate = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final confName = subjectGoal.text;
                      final speakerName = chapterNameController.text;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sending in progress...')),
                      );
                      FocusScope.of(context).requestFocus(FocusNode());

                     CollectionReference subjectsRef = FirebaseFirestore.instance.collection("Subjects");
                     subjectsRef.add({
                       'chapter':speakerName,
                       'date': selectedConfDate,
                       'subject': selectedConfType,
                       "Goal":confName,
                       'avatar' : 'todo',
                     });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.lightGreen, // Texte noir
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Bord arrondi
                  ),
                  child: const Text('Envoyer'), // Texte "Envoyer"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
