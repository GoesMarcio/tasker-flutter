import 'package:flutter/material.dart';
import 'package:tasker/models/task_model.dart';
import 'package:tasker/pages/tasks/tasks_controller.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:tasker/shared/widgets/task_tile.dart/task_tile_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controler = TasksController();

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
                height: 59,
                color: AppColors.shape,
              ),
              Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                    child: TextFormField(
                      onChanged: (value) {
                        _controler.getByName(value);
                      },
                      style: AppTextStyles.inputWhite,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                                color: AppColors.white.withOpacity(0.5),
                                width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: AppColors.white, width: 2)),
                        labelStyle: AppTextStyles.inputWhite,
                        labelText: "Pesquisa",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  )),
            ],
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
