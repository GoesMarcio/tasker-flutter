import 'package:flutter/material.dart';
import 'package:tasker/models/task_model.dart';
import 'package:tasker/pages/tasks/tasks_controller.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:tasker/shared/utils/utils.dart';
import 'package:tasker/shared/widgets/tag_button/tag_widget.dart';

class TaskTileWidget extends StatefulWidget {
  final TaskModel task;
  const TaskTileWidget({Key? key, required this.task}) : super(key: key);

  @override
  _TaskTileWidgetState createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  final _controler = TasksController();
  bool _value = false;

  @override
  void initState() {
    _value = widget.task.check!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(widget.task.title!, style: AppTextStyles.titleListTile),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                child: Text(
                  "${showDate(widget.task.date)}",
                  style: AppTextStyles.captionBody,
                ),
              ),
              Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: widget.task.categories != null
                      ? widget.task.categories!
                          .map((e) => TagWidget(text: e))
                          .toList()
                      : [Container()])
            ],
          ),
          trailing: Checkbox(
            activeColor: AppColors.primary,
            value: _value,
            onChanged: (value) async {
              if (value != null) {
                setState(() {
                  _value = value;
                });
                await _controler.updateTask(widget.task, value);
              }
            },
          ),
        ),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                  spreadRadius: 0.2)
            ]),
      ),
    );
  }
}
