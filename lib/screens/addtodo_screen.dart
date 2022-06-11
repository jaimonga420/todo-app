import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  static const routeName = "/addtodoscreen";

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String taskType = '';
  String taskCategory = '';

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: deviceHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff1d1e26), Color(0xff252041)])),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  color: Colors.white,
                  iconSize: 28,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              const Text(
                'Create',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 25),
                child: Text(
                  'New Todo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              headingText('Task Title'),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff2a2e3d),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _titleController,
                    cursorColor: Colors.white,
                    inputFormatters: [LengthLimitingTextInputFormatter(13)],
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        hintText: 'Enter a task',
                        hintStyle: TextStyle(color: Colors.grey)),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              headingText('Task Type'),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Row(
                  children: [
                    typeSelect('Important', 0xff2664fa),
                    const SizedBox(width: 20),
                    typeSelect('Planned', 0xff2bc8d9),
                  ],
                ),
              ),
              headingText('Description'),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff2a2e3d),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _descController,
                    maxLines: 12,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, right: 15, top: 15, bottom: 15),
                        hintText: 'Enter task description',
                        hintStyle: TextStyle(color: Colors.grey)),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              headingText('Category'),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Row(
                  children: [
                    categorySelect('Food', 0xffff6d6e),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: categorySelect('Workout', 0xfff39732),
                    ),
                    categorySelect('Work', 0xff6557ff),
                  ],
                ),
              ),
              Row(
                children: [
                  categorySelect('Design', 0xff234ebd),
                  const SizedBox(
                    width: 20,
                  ),
                  categorySelect('Run', 0xff2bc8d9),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('todos').add({
                      'title': _titleController.text,
                      'type': taskType,
                      'category': taskCategory,
                      'description': _descController.text
                    });
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => const Color(0xff8a32f1)),
                      minimumSize: MaterialStateProperty.resolveWith<Size>(
                          (states) => const Size(double.maxFinite, 50))),
                  child: const Text(
                    'Add Todo',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget headingText(String heading) {
    return Text(
      heading,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget typeSelect(String label, int color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          taskType = label;
        });
      },
      child: Chip(
        backgroundColor: label == taskType ? Colors.white : Color(color),
        labelPadding: const EdgeInsets.symmetric(vertical: 3.8, horizontal: 17),
        label: Text(
          label,
          style: TextStyle(
              color: label == taskType ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          taskCategory = label;
        });
      },
      child: Chip(
        backgroundColor: label == taskCategory ? Colors.white : Color(color),
        labelPadding: const EdgeInsets.symmetric(vertical: 3.8, horizontal: 17),
        label: Text(
          label,
          style: TextStyle(
              color: label == taskCategory ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
