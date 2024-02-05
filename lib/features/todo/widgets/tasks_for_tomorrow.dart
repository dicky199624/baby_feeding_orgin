

import 'package:baby_feeding/core/common/widgets/white_space.dart';
import 'package:baby_feeding/core/res/colours.dart';
import 'package:baby_feeding/features/todo/app/task_provider.dart';
import 'package:baby_feeding/features/todo/utils/todo_utils.dart';
import 'package:baby_feeding/features/todo/views/add_task_screen.dart';
import 'package:baby_feeding/features/todo/widgets/task_expansion_tile.dart';
import 'package:baby_feeding/features/todo/widgets/todo_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TasksForTomorrow extends ConsumerWidget {
  const TasksForTomorrow ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks =ref.watch(taskProvider);
    return FutureBuilder(
      future: TodoUtils.getTaskForTomorrow(tasks),
      builder: (_, snapshot) {
        if(snapshot.hasData && snapshot.data != null){
          final colour = Colours.RandomColour();
          return TaskExpansionTile(
            title: "Tomorrow's Tasks",
            colour: colour,
            subtitle: "Tomorrow's tasks are shown here",
            children: snapshot.data!.map((task) {
              final isLast = snapshot.data!.indexWhere((element) => element
                  .id == task.id) == snapshot.data!.length - 1;
              return TodoTitle(
                task,
                colour: colour,
                bottomMargin: isLast ? null : 10,
                onDelete: () {
                  ref.read(taskProvider.notifier).deleteTask(task.id!);
                },
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddOrEditTaskScreen(task: task),
                    ),
                  );
                },
                endIcon: Switch(
                  splashRadius: 10,
                  value: task.isCompleted,
                  onChanged: (_) {
                    task.isCompleted = true;
                    ref.read(taskProvider.notifier).markAsCompleted(task);
                  },
                ),
              );
            }).toList(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}