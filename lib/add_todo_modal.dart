
import 'package:flutter/material.dart';
import 'package:shakil/todo.dart';
ButtonStyle elevatedButton = ElevatedButton.styleFrom(backgroundColor: Colors.redAccent);
class MyForm extends StatefulWidget {
  final Function(ToDo) onAdd;
  const MyForm({super.key, required this.onAdd});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _myForm = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(key: _myForm, child: Column(children: [
      TextFormField(
        controller: _titleController,
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            hintText: 'Add Title'),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a title';
          }
          return null;
        },
      ),
      const SizedBox(height: 8,),
      TextFormField(
        controller: _descriptionController,
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            hintText: 'Add Description '),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a description';
          }
          return null;
        },
      ),
      const SizedBox(height: 8,),
      ElevatedButton(onPressed: () {
        if(_myForm.currentState!.validate()){
          ToDo todo = ToDo(title: _titleController.text, description: _descriptionController.text);
          setState(() {
            widget.onAdd(todo);
            _titleController.clear();
            _descriptionController.clear();
          });
        }
      },style: elevatedButton, child: const Text('Add'),),
    ],),
    );
  }
}