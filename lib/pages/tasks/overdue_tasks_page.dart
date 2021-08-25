import 'package:flutter/material.dart';
import 'package:tasker/models/category_model.dart';
import 'package:tasker/models/task_model.dart';
import 'package:tasker/pages/tasks/tasks_controller.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:tasker/shared/widgets/tag_button/tag_button_widget.dart';
import 'package:tasker/shared/widgets/task_tile.dart/task_tile_widget.dart';

class OverdueTasksPage extends StatefulWidget {
  const OverdueTasksPage({Key? key}) : super(key: key);

  @override
  _OverdueTasksPageState createState() => _OverdueTasksPageState();
}

class _OverdueTasksPageState extends State<OverdueTasksPage> {
  final _controler = TasksController();

  @override
  void initState() {
    _controler.getOverdueTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text("Tarefas Atrasadas",
                    style: AppTextStyles.titleBoldHeading)),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                ValueListenableBuilder<List<TaskModel>>(
                    valueListenable: _controler.tasksNotifier,
                    builder: (_, tasks, __) {
                      if (tasks == null || tasks.length == 0) {
                        return Center(
                          child: Container(
                            child: Text(
                              "Nenhuma tarefa!",
                              style: AppTextStyles.buttonBarGrey,
                            ),
                          ),
                        );
                      }
                      return Column(
                        children:
                            tasks.map((e) => TaskTileWidget(task: e)).toList(),
                      );
                    }),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
