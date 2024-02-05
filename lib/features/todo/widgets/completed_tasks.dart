

import 'package:baby_feeding/core/res/colours.dart';
import 'package:baby_feeding/features/todo/app/task_provider.dart';
import 'package:baby_feeding/features/todo/utils/todo_utils.dart';
import 'package:baby_feeding/features/todo/views/add_task_screen.dart';
import 'package:baby_feeding/features/todo/widgets/todo_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks =ref.watch(taskProvider);
    return FutureBuilder(
      future: TodoUtils.getCompletedTasksForToday(tasks),
      builder: (_, snapshot) {
        if(snapshot.hasData && snapshot.data != null){
          if(snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Completed task',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colours.darkBackground.withOpacity(.6),
                  fontSize: 18,
                ),
              ),
            );
          }
          return ColoredBox(
            color: Colours.lightBackground,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final task = snapshot.data![index];
                final isLast = index == snapshot.data!.length - 1;
                return TodoTitle(
                  task,
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
                  endIcon: const Icon(
                    AntDesign.checkcircle,
                    color: Colours.green,
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}