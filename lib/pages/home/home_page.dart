import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tasker/models/task_model.dart';
import 'package:tasker/pages/calendar/calendar_page.dart';
import 'package:tasker/pages/search/search_page.dart';
import 'package:tasker/pages/tasks/overdue_tasks_page.dart';
import 'package:tasker/pages/tasks/tasks_controller.dart';
import 'package:tasker/pages/tasks/tasks_page.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:tasker/shared/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controler = TasksController();

  final iconList = <IconData>[
    Icons.home,
    Icons.search,
    Icons.hide_source,
    Icons.calendar_today
  ];

  final pages = [
    TasksPage(
      key: UniqueKey(),
    ),
    SearchPage(
      key: UniqueKey(),
    ),
    OverdueTasksPage(
      key: UniqueKey(),
    ),
    CalendarPage(
      key: UniqueKey(),
    ),
  ];

  final colorPages = [
    AppColors.shape,
    AppColors.shape,
    AppColors.shape,
    AppColors.shape
  ];

  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    _controler.tasks = _controler.getTasksByDay(DateTime.now());

    return Scaffold(
      backgroundColor: colorPages[_bottomNavIndex],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152.0), // here the desired height
        child: Container(
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              leading: Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: Icon(
                  Icons.add_task_outlined,
                  color: AppColors.primary,
                ),
                alignment: Alignment.center,
              ),
              title:
                  Text("${stringToday()}", style: AppTextStyles.titleRegular),
              subtitle: ValueListenableBuilder<List<TaskModel>>(
                  valueListenable: _controler.tasksNotifier,
                  builder: (_, tasks, __) {
                    return Text.rich(TextSpan(
                        text: "${stringDate()}\n\n",
                        style: AppTextStyles.captionWhite,
                        children: [
                          TextSpan(
                            text: "Você tem ${tasks.length} tarefas para hoje!",
                            style: AppTextStyles.captionShape,
                          )
                        ]));
                  }),
              trailing: InkWell(
                  onTap: () {
                    callInsertPage(context);
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5.0,
                              offset: Offset(0, 2),
                              spreadRadius: 0.0)
                        ]),
                    child: Row(children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 12),
                          Icon(
                            Icons.add,
                            color: AppColors.grey,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Tarefa", style: AppTextStyles.buttonBarGrey),
                        ],
                      ),
                    ]),
                  )),
            ),
          ),
        ),
      ),
      body: Column(
        children: [pages[_bottomNavIndex]],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, size: 28),
        onPressed: () {
          callInsertPage(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.grey,
        iconSize: 26,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }

  void callInsertPage(context) async {
    await Navigator.of(context).pushNamed("/insert_task");
    Navigator.of(context).pushReplacementNamed("/home");
  }
}
