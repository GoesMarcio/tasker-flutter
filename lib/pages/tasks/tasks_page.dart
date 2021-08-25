import 'package:flutter/material.dart';
import 'package:tasker/models/category_model.dart';
import 'package:tasker/models/task_model.dart';
import 'package:tasker/pages/tasks/tasks_controller.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:tasker/shared/widgets/tag_button/tag_button_widget.dart';
import 'package:tasker/shared/widgets/task_tile.dart/task_tile_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _controler = TasksController();

  void changeTasks(String index) {
    setState(() {
      _controler.typeValue = index;
      _controler.getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: size.width,
                height: 39,
                color: AppColors.primary,
              ),
              Container(
                width: size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.shape,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(40))),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text("Minhas Tarefas",
                    style: AppTextStyles.titleBoldHeading)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                      TagButtonWidget(
                          text: "Todas",
                          onTap: () {
                            changeTasks("Todas");
                          },
                          index: 0,
                          tasksController: _controler)
                    ] +
                    categoriesList.asMap().entries.map((entry) {
                      return TagButtonWidget(
                          text: entry.value.name,
                          onTap: () {
                            changeTasks(entry.value.name);
                          },
                          index: entry.key + 1,
                          tasksController: _controler);
                    }).toList(),
              ),
            ),
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
