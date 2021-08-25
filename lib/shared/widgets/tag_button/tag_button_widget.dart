import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasker/pages/tasks/tasks_controller.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';

class TagButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final int? index;
  final TasksController tasksController;

  const TagButtonWidget(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.tasksController,
      this.index})
      : super(key: key);

  @override
  _TagButtonWidgetState createState() => _TagButtonWidgetState();
}

class _TagButtonWidgetState extends State<TagButtonWidget> {
  var _active = false;

  @override
  void initState() {
    if (widget.index == 0) {
      setState(() {
        _active = true;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: widget.tasksController.type,
        builder: (_, active, __) {
          if (active == widget.text) {
            _active = true;
          } else {
            _active = false;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: _active ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.fromBorderSide(BorderSide(
                    color: _active
                        ? AppColors.primary
                        : AppColors.grey.withOpacity(0.4),
                    width: 2)),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  widget.onTap();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  child: Text(
                    widget.text,
                    style: _active
                        ? AppTextStyles.buttonBarWhite
                        : AppTextStyles.buttonBarGrey,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
