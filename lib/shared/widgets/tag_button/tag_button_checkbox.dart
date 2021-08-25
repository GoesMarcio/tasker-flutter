import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';

class TagButtonCheckboxWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const TagButtonCheckboxWidget({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  _TagButtonCheckboxWidgetState createState() =>
      _TagButtonCheckboxWidgetState();
}

class _TagButtonCheckboxWidgetState extends State<TagButtonCheckboxWidget> {
  var _active = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _active ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.fromBorderSide(BorderSide(
            color:
                _active ? AppColors.primary : AppColors.grey.withOpacity(0.4),
            width: 2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          setState(() {
            _active = !_active;
          });
          widget.onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: _active
                    ? AppTextStyles.buttonBarWhite
                    : AppTextStyles.buttonBarGrey,
              ),
              _active
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child:
                          Icon(Icons.check, size: 15, color: AppColors.white),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
