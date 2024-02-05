import 'package:baby_feeding/core/common/widgets/filled_field.dart';
import 'package:baby_feeding/core/common/widgets/round_bttton.dart';
import 'package:baby_feeding/core/common/widgets/white_space.dart';
import 'package:baby_feeding/core/res/colours.dart';
import 'package:baby_feeding/core/utils/core_utils.dart';
import 'package:baby_feeding/features/todo/app/task_date_provider.dart';
import 'package:baby_feeding/features/todo/app/task_provider.dart';
import 'package:baby_feeding/features/todo/model/task_model.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AddOrEditTaskScreen extends StatefulHookConsumerWidget {
  const AddOrEditTaskScreen({super.key, this.task});

  final TaskModel? task;

  @override
  ConsumerState<AddOrEditTaskScreen> createState() => _AddOrEditTaskScreenState();
}

class _AddOrEditTaskScreenState extends ConsumerState<AddOrEditTaskScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.task != null) {
        ref.read(taskDateProvider.notifier).changeDate(widget.task!.date!);
        ref.read(taskStartTimeProvider.notifier).changeTime(widget.task!.startTime!);
        ref.read(taskEndTimeProvider.notifier).changeTime(widget.task!.endTime!);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: widget.task?.title);
    final descriptionController = useTextEditingController(text: widget.task?.description);
    final dateNotifier = ref.read(taskDateProvider.notifier);
    final startTimeNoitifier = ref.read(taskStartTimeProvider.notifier);
    final EndTimeNoitifier = ref.read(taskEndTimeProvider.notifier);

    final dateProvider = ref.watch(taskDateProvider);
    final startProvider = ref.watch(taskStartTimeProvider);
    final endProvider = ref.watch(taskEndTimeProvider);



    final hintStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: Colours.lightGrey,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colours.light,
      ),
      body: SafeArea(
        child:ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          const WhiteSpace(height: 20),
          FilledFiled(
            controller: titleController,
            hintText: 'Add baby food',
            hintStyle: hintStyle,
          ),
          const WhiteSpace(height: 20),
          FilledFiled(
            controller: descriptionController,
            hintText: 'Add food ML or other',
            hintStyle: hintStyle,
          ),
          const WhiteSpace(height: 20),
          RoundButton(
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                minTime: DateTime.now(),
                maxTime: DateTime(DateTime.now().year + 1),
                theme: DatePickerTheme(
                  doneStyle: GoogleFonts.poppins(
                    //donestyle is the done buttone of datepicker
                    fontSize: 16,
                    color: Colours.green
                  ),
                ),
                onConfirm: (date) {
                  dateNotifier.changeDate(date);
                },
              );
            },
              text: dateProvider == null
                  ? 'set date'
                  : dateNotifier.date()!,
            backgroundColour: Colours.lightGrey,
            borderColour: Colours.light,
          ),
          const WhiteSpace(height: 20),
          Row(
            children: [
              Expanded(
                child: RoundButton(
                  onPressed: () {
                    if (dateProvider == null) {
                      CoreUtils.showSnackBar(
                          context: context,
                          message: 'please pick a date first',
                      );
                      return;
                    }
                    DatePicker.showDateTimePicker(
                      context,
                      currentTime: dateProvider,
                      onConfirm: (time) {
                        startTimeNoitifier.changeTime(time);
                      },
                    );
                  },
                  text: startProvider == null
                      ? 'Start time'
                      : startTimeNoitifier.time()!,
                  backgroundColour: Colours.lightGrey,
                  borderColour: Colours.light,
                ),
              ),
              const WhiteSpace(width: 20),
              Expanded(
                child: RoundButton(
                  onPressed: () {
                    if (startProvider == null) {
                      CoreUtils.showSnackBar(
                        context: context,
                        message: 'please pick a start time first',
                      );
                      return;
                    }
                    DatePicker.showDateTimePicker(
                      context,
                      currentTime: dateProvider,
                      onConfirm: (time) {
                        EndTimeNoitifier.changeTime(time);
                      },
                    );
                  },
                  text: endProvider == null
                      ? 'End time'
                      :EndTimeNoitifier.time()!,
                  backgroundColour: Colours.darkGrey,
                  borderColour: Colours.light,
                ),
              ),
            ],
          ),
          const WhiteSpace(height: 20),
          RoundButton(
            onPressed: () async {
              if(titleController.text.trim().isNotEmpty &&
                  descriptionController.text.trim().isNotEmpty &&
                  dateProvider != null && startProvider != null &&
                  endProvider != null) {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();
                final date = dateProvider;
                final startTime = startProvider;
                final endtime = endProvider;
                final navigatior = Navigator.of(context);
                CoreUtils.showLoader(context);
                final task = TaskModel(
                  id: widget.task?.id,
                  repeat: widget.task == null ? true : widget.task!.repeat,
                  remind: widget.task == null ? true : widget.task!.remind,
                  title: title,
                  description: description,
                  date: date,
                  startTime: startTime,
                  endTime: endtime,
                );
                if(widget.task != null) {
                  await ref.read(taskProvider.notifier).updateTask(task);
                } else {
                  await ref.read(taskProvider.notifier).addTask(task);
                }
                navigatior..pop()..pop();
              } else {
                CoreUtils.showSnackBar(
                    context: context,
                    message: 'All Fields Are Required',
                );
              }
            },
            text: 'Submit',
            backgroundColour: Colours.green,
            borderColour: Colours.light,
          ),
        ],
        ),
      ),
    );
  }
}
