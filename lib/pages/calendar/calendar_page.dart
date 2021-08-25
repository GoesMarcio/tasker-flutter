import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasker/models/task_model.dart';
import 'package:tasker/pages/tasks/tasks_controller.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:tasker/shared/widgets/task_tile.dart/task_tile_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _controler = TasksController();
  List<TaskModel> _tasks = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<bool>(
        future: getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TableCalendar(
                locale: 'pt_BR',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                onDaySelected: (day, day2) {
                  var _a = [];

                  for (var item in _tasks) {
                    if (item.date!.year == day.year &&
                        item.date!.month == day.month &&
                        item.date!.day == day.day) {
                      _a.add(item);
                    }
                  }

                  if (_a.length == 0) return;

                  showMaterialModalBottomSheet(
                    barrierColor: Colors.black.withOpacity(0.6),
                    context: context,
                    builder: (context) => Container(
                      color: AppColors.shape,
                      height: size.height * 0.75,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: Text("${_a.length} Tarefas para esse dia",
                                  style: AppTextStyles.titleBoldHeading),
                            ),
                            Column(
                              children: _a
                                  .map((e) => TaskTileWidget(task: e))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                eventLoader: (day) {
                  var _a = [];

                  for (var item in _tasks) {
                    if (item.date!.year == day.year &&
                        item.date!.month == day.month &&
                        item.date!.day == day.day) {
                      _a.add(item);
                    }
                  }

                  if (_a.length > 0) {
                    return [_a];
                  }

                  return [];
                },
                onFormatChanged: (a) {
                  print(a);
                });
          } else {
            return Container(
              child: Text("Carregando"),
            );
          }
        });
  }

  Future<bool> getTasks() async {
    await _controler.getTasks();
    _tasks = await _controler.getTasksM();

    return true;
  }
}
