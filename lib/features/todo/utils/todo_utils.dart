
import 'package:baby_feeding/features/todo/model/task_model.dart';
import 'package:flutter/material.dart';

class TodoUtils {
  const TodoUtils._();

  static Future<List<TaskModel>> getTaskForToday(List<TaskModel> allTasks,)
  async {
    final today = DateTime.now();

    if(allTasks.isEmpty) return allTasks;

    return allTasks.where((task) {
      return DateUtils.isSameDay(task.date, today);
    }).toList();
  }

  static Future<List<TaskModel>> getTaskForTomorrow(List<TaskModel> allTasks,) async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    if(allTasks.isEmpty) return allTasks;

    return allTasks.where((task) {
      return DateUtils.isSameDay(task.date, tomorrow);
    }).toList();
  }

  static Future<List<TaskModel>> getTaskForDayAfterTomorrow(List<TaskModel> allTasks,) async {
    final dayAfterTomorrow = DateTime.now().add(const Duration(days: 1));

    if(allTasks.isEmpty) return allTasks;

    return allTasks.where((task) {
      return DateUtils.isSameDay(task.date, dayAfterTomorrow);
    }).toList();
  }

  static Future<List<TaskModel>> getTaskFromOneMonthAgo(List<TaskModel> allTasks,) async {
    final oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));

    if(allTasks.isEmpty) return allTasks;

    return allTasks.where((task) {
      return task.date!.isAfter(oneMonthAgo) &&
          task.date!.isBefore(DateUtils.dateOnly(DateTime.now()));
    }).toList();
  }

  static Future<List<TaskModel>>getCompletedTasksForToday(List<TaskModel> allTasks,) async {
    if(allTasks.isEmpty) return allTasks;

    final tasksForToday = await getTaskForToday(allTasks);

    return tasksForToday.where((task) => task.isCompleted).toList();
  }

  static Future<List<TaskModel>>getActiveTasksForToday(List<TaskModel> allTasks,) async {
    if(allTasks.isEmpty) return allTasks;

    final tasksForToday = await getTaskForToday(allTasks);

    return tasksForToday.where((task) => !task.isCompleted).toList();
  }
}