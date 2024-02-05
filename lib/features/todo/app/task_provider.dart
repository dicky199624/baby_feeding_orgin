import 'dart:math';

import 'package:baby_feeding/core/helper/db_helper.dart';
import 'package:baby_feeding/core/res/colours.dart';
import 'package:baby_feeding/features/todo/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_provider.g.dart';

@riverpod
class Task extends _$Task {
  @override
  List<TaskModel> build() => [];

  void refresh() async {
    final data = await DBHelper.getTasks();
    state = data.map((taskData) {
          return TaskModel.fromMap(taskData);
        }).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await DBHelper.addTask(task);
    refresh();
  }

  Future<void> deleteTask(int taskId) async {
    await DBHelper.deleteTask(taskId);
    refresh();
  }

  Future<void> updateTask(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }

  Future<void> markAsCompleted(TaskModel task) async {
    await updateTask(task);
  }
}