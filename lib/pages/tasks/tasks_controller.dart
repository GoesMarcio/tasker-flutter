import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasker/models/task_model.dart';

class TasksController {
  final type = ValueNotifier<String>("Todas");

  String get typeValue => type.value;
  set typeValue(String value) => type.value = value;

  final tasksNotifier = ValueNotifier<List<TaskModel>>(<TaskModel>[]);

  List<TaskModel> get tasks => tasksNotifier.value;
  set tasks(List<TaskModel> value) => tasksNotifier.value = value;

  TasksController() {
    getTasks();
  }

  Future<void> getTasks() async {
    try {
      if (typeValue == "Todas") {
        final instance = await SharedPreferences.getInstance();
        final response = instance.getStringList("tasker_tasks") ?? <String>[];
        tasks = response.map((e) => TaskModel.fromJson(e)).toList();
      } else {
        final instance = await SharedPreferences.getInstance();
        final response = instance.getStringList("tasker_tasks") ?? <String>[];
        var auxTasks = response.map((e) => TaskModel.fromJson(e)).toList();

        tasks = <TaskModel>[];

        for (var item in auxTasks) {
          if (item.categories!.contains(typeValue)) {
            tasks.add(item);
          }
        }
      }
    } catch (e) {
      tasks = <TaskModel>[];
    }
  }

  Future<void> getOverdueTasks() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("tasker_tasks") ?? <String>[];
      var auxTasks = response.map((e) => TaskModel.fromJson(e)).toList();

      tasks = <TaskModel>[];

      for (var item in auxTasks) {
        if (!(item.check!) && (item.date!.compareTo(DateTime.now()) <= 0)) {
          tasks.add(item);
        }
      }
    } catch (e) {
      tasks = <TaskModel>[];
    }
  }

  Future<void> getByName(String value) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("tasker_tasks") ?? <String>[];
      var auxTasks = response.map((e) => TaskModel.fromJson(e)).toList();

      tasks = <TaskModel>[];

      for (var item in auxTasks) {
        if ((item.title!.toLowerCase().contains(value.toLowerCase()))) {
          tasks.add(item);
        }
      }
    } catch (e) {
      tasks = <TaskModel>[];
    }
  }

  List<TaskModel> getTasksByDay(day) {
    var retTasks = <TaskModel>[];
    try {
      for (var item in tasks) {
        if (item.date!.year == day.year &&
            item.date!.month == day.month &&
            item.date!.day == day.day) {
          retTasks.add(item);
        }
      }
    } catch (e) {
      retTasks = <TaskModel>[];
    }
    return retTasks;
  }

  List<TaskModel> getTasksM() {
    return tasks;
  }

  Future<void> updateTask(TaskModel task, bool value) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("tasker_tasks") ?? <String>[];
      var auxTasks = response.map((e) => TaskModel.fromJson(e)).toList();

      var aux = auxTasks.indexOf(task);

      auxTasks[aux] = auxTasks[aux].copyWith(check: value);

      await instance.setStringList(
          "tasker_tasks", auxTasks.map((e) => e.toJson()).toList());

      return;
    } catch (e) {
      tasks = <TaskModel>[];
    }
  }
}
