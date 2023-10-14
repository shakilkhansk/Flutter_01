import 'package:flutter/material.dart';
import 'package:shakil/todo.dart';
ButtonStyle elevatedButton = ElevatedButton.styleFrom(backgroundColor: Colors.redAccent);
class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key, required this.onUpdate, required this.initialToDo});
  final Function(ToDo) onUpdate;
  final ToDo initialToDo;

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final _updateTitleController = TextEditingController();
  final _updateDescriptionController = TextEditingController();
  final _myForm = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _updateTitleController.text = widget.initialToDo.title;
    _updateDescriptionController.text = widget.initialToDo.description;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(key: _myForm, child: Column(children: [
        TextFormField(
          controller: _updateTitleController,
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
          controller: _updateDescriptionController,
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              hintText: 'Add Description'),
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
            ToDo todo = ToDo(title: _updateTitleController.text, description: _updateDescriptionController.text);
            setState(() {
              widget.onUpdate(todo);
              Navigator.pop(context);
            });
          }
        },style: elevatedButton, child: const Text('Update'),),
      ],),
      ),
    );
  }
}
