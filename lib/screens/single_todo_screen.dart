import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SingleTodoScreen extends StatefulWidget {
  const SingleTodoScreen({Key? key, required this.documents}) : super(key: key);
  final dynamic documents;

  @override
  State<SingleTodoScreen> createState() => _SingleTodoScreenState();
}

class _SingleTodoScreenState extends State<SingleTodoScreen> {
  TextEditingController? _titleController;
  TextEditingController? _descController;
  String? taskType;
  String? taskCategory;
  bool _isEditing = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.documents['title']);
    _descController =
        TextEditingController(text: widget.documents['description']);
    taskType = widget.documents['type'];
    taskCategory = widget.documents['category'];
    super.initState();
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      color: Colors.white,
                      iconSize: 28,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Row(
                    children: [
                      IconButton(
                          color: Colors.red,
                          iconSize: 28,
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('todos')
                                .doc(widget.documents.id)
                                .delete();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          color: _isEditing ? Colors.white : Colors.red,
                          iconSize: 28,
                          onPressed: !_isEditing
                              ? () {
                                  setState(() {
                                    _isEditing = !_isEditing;
                                  });
                                }
                              : () {
                                  FirebaseFirestore.instance
                                      .collection('todos')
                                      .doc(widget.documents.id)
                                      .update({
                                    'title': _titleController!.text,
                                    'type': taskType,
                                    'category': taskCategory,
                                    'description': _descController!.text
                                  });
                                  Navigator.pop(context);
                                },
                          icon: _isEditing
                              ? Icon(Icons.check)
                              : Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              Text(
                widget.documents['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: headingText('Task Title'),
              ),
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
                    enabled: _isEditing,
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
                    enabled: _isEditing,
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
      onTap: _isEditing
          ? () {
              setState(() {
                taskType = label;
              });
            }
          : null,
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
      onTap: _isEditing
          ? () {
              setState(() {
                taskCategory = label;
              });
            }
          : null,
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
