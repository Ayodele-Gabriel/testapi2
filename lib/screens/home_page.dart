import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapi2/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TodoProvider>(context, listen: false).getAllTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider API'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final todos = value.todos;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: todo.completed ? Colors.grey : Colors.blueGrey,
                  child: Text(
                    todo.id.toString(),
                    style: TextStyle(
                      color: todo.completed ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    color: todo.completed ? Colors.grey : Colors.black,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
