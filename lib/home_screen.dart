import 'package:flutter/material.dart';
import 'package:shakil/todo.dart';
import 'package:shakil/updateTodoModal.dart';

import 'add_todo_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
ButtonStyle elevatedButton = ElevatedButton.styleFrom(backgroundColor: Colors.redAccent);
class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> todos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Icon(Icons.search, color: Colors.black,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyForm(onAdd: (todo) {
              setState(() {
                todos.add(todo);
              });
            },),
            const SizedBox(height: 28,),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onLongPress: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text('Alert'),
                          actions: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                                showModalBottomSheet(context: context, builder: (context) {
                                  return UpdateTodo(initialToDo: todos[index], onUpdate: (todo ) {
                                    setState(() {
                                      todos[index] = todo;
                                    });
                                  },);
                                },);
                              }, child: const Text('Edit')),
                                TextButton(onPressed: () {
                                  setState(() {
                                    todos.removeAt(index);
                                    Navigator.pop(context);
                                  });
                              }, child: const Text('Delete')),
                            ],)
                          ],
                        );
                      },);
                    },
                    title: Text(todos[index].title),
                    subtitle: Text(todos[index].description),
                    leading: CircleAvatar(backgroundColor: Colors.redAccent, child: Text('${index+1}')),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                  ),
                );
              },itemCount: todos.length,),
            )
          ],
        ),
      ),
    );
  }
}