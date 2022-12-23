import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saathi/features/goal/presentation/custom_widgets/create_goal_widget.dart';

import '../application/goal_service.dart';
import '../data/goal_repository_impl.dart';

class EditGoal extends ConsumerStatefulWidget {
  const EditGoal({Key? key}) : super(key: key);

  @override
  _EditGoalState createState() => _EditGoalState();
}

class _EditGoalState extends ConsumerState<EditGoal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit goal'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CreateGoalWidget(
            goalModel: ref.read(goalStateProvider.notifier).state,
          ),
        ),
      ),
    );
  }
}
