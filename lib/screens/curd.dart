// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/screens/imagepicker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TodoScreen extends StatefulWidget {
  File? image;
  TodoScreen({super.key, this.image});
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // XFile? pick;
  // File? image;
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late String _taskIdForUpdate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          actions: [
            InkWell(
              onTap: () {
                // ImagePicker picked = ImagePicker();
                //   pick = await picked.pickImage(source: ImageSource.gallery);
            
                //   setState(() {
                //     image = File(pick!.path);
                //   });
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePickerr(),));
              },
              child: CircleAvatar(
                 backgroundImage: widget.image!=null ? FileImage(widget.image!) : null,
                 child: widget.image == null? Icon(Icons.person):null,
                  // child: image == null? Text('no image'): Image.file(image!),
              ),
            ),
            
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('todos').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
      
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var todo = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(todo['task']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _taskIdForUpdate = todo.id;
                          _taskController.text = todo['task'];
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Edit Task'),
                                content: TextField(
                                  controller: _taskController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your task',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (_taskController.text.isNotEmpty) {
                                        FirebaseFirestore.instance
                                            .collection('todos')
                                            .doc(_taskIdForUpdate)
                                            .update({
                                          'task': _taskController.text,
                                        });
                                        _taskController.clear();
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Text('Update'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('todos')
                              .doc(todo.id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add Task'),
                  content: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(hintText: 'Enter your task'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_taskController.text.isNotEmpty) {
                          FirebaseFirestore.instance.collection('todos').add({
                            'task': _taskController.text,
                          });
                          _taskController.clear();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
