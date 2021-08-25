import 'package:flutter/material.dart';
import 'package:tasker/models/category_model.dart';
import 'package:tasker/pages/insert_task/insert_task_controller.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:tasker/shared/utils/utils.dart';
import 'package:tasker/shared/widgets/back_button/back_button_widget.dart';
import 'package:tasker/shared/widgets/tag_button/tag_button_checkbox.dart';
import 'package:tasker/shared/widgets/text_input/date_input_form.dart';
import 'package:tasker/shared/widgets/text_input/hour_input_form.dart';
import 'package:tasker/shared/widgets/text_input/text_input_form.dart';
import 'package:intl/intl.dart';

class InsertTaskPage extends StatefulWidget {
  const InsertTaskPage({Key? key}) : super(key: key);

  @override
  _InsertTaskPageState createState() => _InsertTaskPageState();
}

class _InsertTaskPageState extends State<InsertTaskPage> {
  @override
  Widget build(BuildContext context) {
    final controller = InsertTaskController();

    final formatDay = DateFormat("dd/MM/yyyy");
    final formatHour = DateFormat("HH:mm");

    var myDate = "";
    var myHour = "";

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text("Nova Tarefa", style: AppTextStyles.titleBoldHeading),
        leading: BackButtonWidget(color: AppColors.input),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: 'Nome da tarefa',
                      validator: controller.validateTitle,
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChanged(title: value);
                      },
                    ),
                    InputDateWidget(
                      format: formatDay,
                      label: 'Dia',
                      validator: controller.validateDate,
                      icon: Icons.calendar_today,
                      onChanged: (value) {
                        myDate = dateToString(value!);

                        controller.onChanged(
                            date:
                                DateTime.parse((myDate + " " + myHour).trim()));
                      },
                    ),
                    InputHourWidget(
                      format: formatHour,
                      label: 'Horário',
                      validator: controller.validateDate,
                      icon: Icons.lock_clock,
                      onChanged: (value) {
                        myHour = timeToString(value!);

                        controller.onChanged(
                            date:
                                DateTime.parse((myDate + " " + myHour).trim()));
                      },
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
              child: Wrap(
                spacing: 12,
                runSpacing: 6,
                children: categoriesList.map((entry) {
                  return TagButtonCheckboxWidget(
                    text: entry.name,
                    onTap: () {
                      if (controller.myCategories.contains(entry.name)) {
                        controller.myCategories.remove(entry.name);
                      } else {
                        controller.myCategories.add(entry.name);
                      }
                      controller.onChanged(categories: controller.myCategories);
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    if (await controller.cadastrarTask()) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 12),
                            Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Adicionar tarefa",
                                style: AppTextStyles.buttonBarWhite),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
