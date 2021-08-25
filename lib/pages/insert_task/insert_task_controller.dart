import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasker/models/task_model.dart';

class InsertTaskController {
  final formKey = GlobalKey<FormState>();
  TaskModel model = TaskModel();
  List<String> myCategories = [];

  String? validateTitle(String? value) =>
      value?.isEmpty ?? true ? "O titulo não pode ser vazio" : null;
  String? validateDate(DateTime? value) =>
      value == null ? "A data de vencimento não pode ser vazio" : null;

  void onChanged({String? title, DateTime? date, List<String>? categories}) {
    model = model.copyWith(
        title: title, date: date, check: false, categories: categories);
  }

  Future<bool> saveTask() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final tasks = instance.getStringList("tasker_tasks") ?? <String>[];
      tasks.add(model.toJson());

      await instance.setStringList("tasker_tasks", tasks);

      return true;
    } catch (e) {}

    return false;
  }

  Future<bool> cadastrarTask() async {
    final form = await formKey.currentState;
    if (form!.validate()) {
      return await saveTask();
    }

    return false;
  }
}
