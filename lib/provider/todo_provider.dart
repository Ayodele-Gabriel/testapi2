import 'package:flutter/cupertino.dart';
import 'package:testapi2/services/todo_services.dart';

import '../model/todo.dart';

class TodoProvider extends ChangeNotifier{
  TodoServices _services = TodoServices();

  bool isLoading = false;
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> getAllTodos() async{
    isLoading = true;
    notifyListeners();

    final response = await _services.getAll();

    _todos = response;
    isLoading = false;
    notifyListeners();
  }

}